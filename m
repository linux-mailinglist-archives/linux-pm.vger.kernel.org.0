Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30A62038
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 16:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfGHONH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 10:13:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59782 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfGHONH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 10:13:07 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E417D804BC; Mon,  8 Jul 2019 16:12:51 +0200 (CEST)
Date:   Mon, 8 Jul 2019 16:13:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: cpufreq notifiers break suspend -- Re: suspend broken in
 next-20190704 on Thinkpad X60
Message-ID: <20190708141302.GA7436@amd>
References: <20190704192020.GA3771@amd>
 <CAJZ5v0gn7FWpqW+WmCzj1=K-pjY=SjRNuEsMR3bRTSO8FzFG=Q@mail.gmail.com>
 <20190705185001.GA4068@amd>
 <CAJZ5v0irbn-Xd47KExw=h7On7KShCm6rThCo0q4-zn=o_x6_HQ@mail.gmail.com>
 <20190706203032.GA26828@amd>
 <20190708030505.kvrg6sh6bd4xzzwa@vireshk-i7>
 <CAJZ5v0hTXtjkatT4wVftPac-LgL1GSAbwLZ0mMDSpFn=8k9Ssg@mail.gmail.com>
 <20190708092840.ynibtrntval6krc4@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20190708092840.ynibtrntval6krc4@vireshk-i7>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-07-08 14:58:40, Viresh Kumar wrote:
> On 08-07-19, 10:28, Rafael J. Wysocki wrote:
> > Pavel has tested the latest version of the patch series AFAICS.
> >=20
> > The locking added by the commit in question to
> > refresh_frequency_limits() requires an update of
> > cpufreq_update_policy(), or it will deadlock in there because of the
> > lock acquired by cpufreq_cpu_get() if I haven't missed anything.
>=20
> Ah, looks quite straight forward.
>=20
> @Pavel: Can you please try this diff ?

I tried to apply it on top of current next
(d58b5ab90ee7528126fd5833df7fc5bda8331ce8, 20190708) and linux-pm-next
(1e2a4c9019eb53f62790fadf86c14a54f4cf4888), but failed due to
whitespace (?!).

Yes, symptoms would be consistent with deadlock on resume.

And yes, the patch seems to fix problem for me.

Tested-by: Pavel Machek <pavel@ucw.cz>
									Pavel

> -------------------------8<-------------------------
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 9f68d0f306b8..4d6043ee7834 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1109,16 +1109,12 @@ void refresh_frequency_limits(struct cpufreq_poli=
cy *policy)
>  {
>         struct cpufreq_policy new_policy;
> =20
> -       down_write(&policy->rwsem);
> -
>         if (!policy_is_inactive(policy)) {
>                 new_policy =3D *policy;
>                 pr_debug("updating policy for CPU %u\n", policy->cpu);
> =20
>                 cpufreq_set_policy(policy, &new_policy);
>         }
> -
> -       up_write(&policy->rwsem);
>  }
>  EXPORT_SYMBOL(refresh_frequency_limits);
> =20
> @@ -1128,7 +1124,9 @@ static void handle_update(struct work_struct *work)
>                 container_of(work, struct cpufreq_policy, update);
> =20
>         pr_debug("handle_update for cpu %u called\n", policy->cpu);
> +       down_write(&policy->rwsem);
>         refresh_frequency_limits(policy);
> +       up_write(&policy->rwsem);
>  }
> =20
> -------------------------8<-------------------------
>=20
> Though it makes me wonder why I didn't hit this thing. I was using the
> cpu_cooling device the other day, which calls cpufreq_update_policy()
> very frequently on heat-up. And I had a hair dryer blowing over my
> board to heat it up. Lemme check that again :)

Can you test on some x86 ACPI? No dryers needed :-).

> @Rafael: You want me to send a new diff patch with Fixes tag this time
> if this works out fine ?



									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0jT24ACgkQMOfwapXb+vJHdwCgrvUmjj9YupNxGOvP7lJkGwE3
gq8An0mWk7KXRuwmS4H/FqqOX3FQ4V8e
=OO7t
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
