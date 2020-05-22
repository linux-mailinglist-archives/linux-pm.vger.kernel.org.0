Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B4D1DE929
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgEVOnR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 10:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbgEVOnR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 10:43:17 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAB7C061A0E;
        Fri, 22 May 2020 07:43:17 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k19so9434611edv.9;
        Fri, 22 May 2020 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pEMnosclMENELxtgkfNlqnRlbAPuv7/WGXXU3o+3Wgk=;
        b=qKkCPN704QYXuch7cQD5KsRch8SM+Fq9IMwTFvTcpf3kTg9cv+vqBfsXxt8gM8j3Ck
         Z/5F24AEHclpbrV533kWoRNzD8W/PoJ1/F8OMl5/gkA6fQ5kFMT0x0EVK+HlFxnEyw5A
         9A/+BuuLZYZ5B3ULz6GxHOD/Xsu7SL9y3PwtgpWz3j7OmG1OIk9eHlrwfl48yzdxwEez
         N8c+nA2nTGE+TC5t4C8meFkKsC1sgs62kFquqYj3uVPPezktkThNmH9JMhblVQ3Kzrb6
         x05tyFSQccbls+scPBrEeI7pNjNRycpdGUWrnFlw/QpC4bb0RohfFJIT9nd0nQoChgZZ
         UqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pEMnosclMENELxtgkfNlqnRlbAPuv7/WGXXU3o+3Wgk=;
        b=puaWe5Y7rPc22ThDCgJJZSAbnbia+FwHtmG4DOK3YD8zwdU/Nd+KApcJ9ZbAl6DK4c
         MStV/aveQjoBrsUEsMHrRoynhb5iIjoFZKTS2BV3yS3cN/bJi04TqlvN/CsFFgrzc/Pl
         vyhl4MuL5bCnQkWeVOAVkz/3KLtRxvfl/AaPhYei+sAjWu2dUYsU1koMrYpDrn5m+Drz
         vl5eHiCDcUmtcy1vlArXS6EaZYf3lH9rtUECRRbSBDRCEmNal5SzRxjjo7mBkYQ/hwCC
         DEgnzalvkSsN0pIBUrsr+GnTAf5m6CsG+XrQxm2eKyzbPp8eRbBJmbbTB48TIrIKTo81
         aoqg==
X-Gm-Message-State: AOAM530x01cIiyjIV9tl4Z93ygi181+dlxEuXTUz2QrUj0h6uecHuwtH
        rwYP6UOhmj/d3hrq+09D3dU=
X-Google-Smtp-Source: ABdhPJxQKMSVP7UsCOBRlGM0TjNDYKXZhvaGaCnYahr/v+jJ65GzxqvZSy31ohwwlHMRkM8jH6VSTg==
X-Received: by 2002:a05:6402:946:: with SMTP id h6mr3309459edz.245.1590158595504;
        Fri, 22 May 2020 07:43:15 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id w14sm8284896ejk.13.2020.05.22.07.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:43:13 -0700 (PDT)
Date:   Fri, 22 May 2020 16:43:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        dinghao.liu@zju.edu.cn, Kangjie Lu <kjlu@umn.edu>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: Re: [PATCH] media: staging: tegra-vde: fix runtime pm imbalance
 on error
Message-ID: <20200522144312.GA2374603@ulmo>
References: <20200520095148.10995-1-dinghao.liu@zju.edu.cn>
 <2b5d64f5-825f-c081-5d03-02655c2d9491@gmail.com>
 <20200520150230.GC30374@kadam>
 <2a46539d.b977f.1723553aa81.Coremail.dinghao.liu@zju.edu.cn>
 <20200521091505.GF30374@kadam>
 <CAJZ5v0irLayBUPRWNT1tcZivz9inS1YbUgGj5WXvucLKKwRQAw@mail.gmail.com>
 <20200521173901.GA22310@kadam>
 <20200522131031.GL2163848@ulmo>
 <20200522132318.GM30374@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20200522132318.GM30374@kadam>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 04:23:18PM +0300, Dan Carpenter wrote:
> On Fri, May 22, 2020 at 03:10:31PM +0200, Thierry Reding wrote:
> > On Thu, May 21, 2020 at 08:39:02PM +0300, Dan Carpenter wrote:
> > > On Thu, May 21, 2020 at 05:22:05PM +0200, Rafael J. Wysocki wrote:
> > > > On Thu, May 21, 2020 at 11:15 AM Dan Carpenter <dan.carpenter@oracl=
e.com> wrote:
> > > > >
> > > > > On Thu, May 21, 2020 at 11:42:55AM +0800, dinghao.liu@zju.edu.cn =
wrote:
> > > > > > Hi, Dan,
> > > > > >
> > > > > > I agree the best solution is to fix __pm_runtime_resume(). But =
there are also
> > > > > > many cases that assume pm_runtime_get_sync() will change PM usa=
ge
> > > > > > counter on error. According to my static analysis results, the =
number of these
> > > > > > "right" cases are larger. Adjusting __pm_runtime_resume() direc=
tly will introduce
> > > > > > more new bugs. Therefore I think we should resolve the "bug" ca=
ses individually.
> > > > > >
> > > > >
> > > > > That's why I was saying that we may need to introduce a new repla=
cement
> > > > > function for pm_runtime_get_sync() that works as expected.
> > > > >
> > > > > There is no reason why we have to live with the old behavior.
> > > >=20
> > > > What exactly do you mean by "the old behavior"?
> > >=20
> > > I'm suggesting we leave pm_runtime_get_sync() alone but we add a new
> > > function which called pm_runtime_get_sync_resume() which does somethi=
ng
> > > like this:
> > >=20
> > > static inline int pm_runtime_get_sync_resume(struct device *dev)
> > > {
> > > 	int ret;
> > >=20
> > > 	ret =3D __pm_runtime_resume(dev, RPM_GET_PUT);
> > > 	if (ret < 0) {
> > > 		pm_runtime_put(dev);
> > > 		return ret;
> > > 	}
> > > 	return 0;
> > > }
> > >=20
> > > I'm not sure if pm_runtime_put() is the correct thing to do?  The oth=
er
> > > thing is that this always returns zero on success.  I don't know that
> > > drivers ever care to differentiate between one and zero returns.
> > >=20
> > > Then if any of the caller expect that behavior we update them to use =
the
> > > new function.
> >=20
> > Does that really have many benefits, though? I understand that this
> > would perhaps be easier to use because it is more in line with how other
> > functions operate. On the other hand, in some cases you may want to call
> > a different version of pm_runtime_put() on failure, as discussed in
> > other threads.
>=20
> I wasn't CC'd on the other threads so I don't know.  :/

It was actually earlier in this thread, see here for example:

	http://patchwork.ozlabs.org/project/linux-tegra/patch/20200520095148.10995=
-1-dinghao.liu@zju.edu.cn/#2438776

> I have always assumed it was something like this but I don't know the
> details and there is no documentation.

Now, I don't know more than you do, but it sounds to me like there are
multiple valid ways that we can use to drop the runtime PM reference and
whatever we choose to do in this new function may not always be the
right thing.

> http://sweng.the-davies.net/Home/rustys-api-design-manifesto
> You're essentially arguing that it's a #1 on Rusty's scale but ideally
> we would want to be at #7.

I think we could probably get it to at least a 3 or a 4 on that list if
we add a bit of documentation and fix all existing users.

Yes, 7 would be better than that, but I think we have to weigh the cost
of the added fragmentation versus the benefits that it gives us.

> > Even ignoring that issue, any existing callsites that are leaking the
> > reference would have to be updated to call the new function, which would
> > be pretty much the same amount of work as updating the callsites to fix
> > the leak, right?
>=20
> With the current API we're constantly adding bugs.  I imagine that once
> we add a straight forward default and some documentation then we will
> solve this.

In my experience this stuff is often copy/pasted, so once we fix up all
of the bugs (and perhaps even add a coccinelle script) we shoudl be
seeing less bugs added all the time.

That said, I'm not opposed to adding a new function if we can make it
actually result in an overall improvement. What I'd hate to do is add a
new API that we all think is superior but then ends up not being usable
in half of the cases.

> > So if instead we just fix up the leaks, we might have a case of an API
> > that doesn't work as some of us (myself included) expected it, but at
> > least it would be consistent. If we add another variant things become
> > fragmented and therefore even more complicated to use and review.
>=20
> That's the approach that we've been trying and it's clearly not working.

I think this is something we can likely solve through education and
documentation. Runtime PM is still a fairly new topic that not a lot of
people have experience with (at least if I extrapolate from the many
issues I've run into lately related to runtime PM), so I think it just
takes time for everyone to catch up. This looks similar to me to how we
used to have every allocation failure print out an error, even though
the allocator already complains pretty loudly when things go wrong. Now
we've removed most (if not all) of the redundant error messages and it's
become common knowledge among most maintainers, so new instances
typically get caught during review.

But again, if you can come up with a good alternative that works for the
majority of cases I think that would also be fine. Getting things right
without actually knowing any of the background is obviously better than
having to actually educate people. =3D)

Thierry

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7H5P4ACgkQ3SOs138+
s6Fm5xAAuyo73K+oaTfn9V3Xq+33bmmc26jVlg+RaqH4wb7uGlyZ3RnfCrpZ5no2
UsfcaSG3gQjWqMjRIUDFTt4n7upoJVkQ4LnWHOxOTKE6z1dtzdm0b+U29MuGeEnj
ETKlbh9FBF+uQtyoPW+5KL2msrgBW8Wt5xRhWcN7W6Mkzg90urOK91+QpZlnuc8a
B2ENjxDrUhhnMll00CkvbvQ+ihH53MpkVJ+3L8fOO5pC9yHrZkM71lPOH5obfuCh
bYzHLEN9Hy3np3VSTavM0PJCqQVzx8b9cwk0PN+hSx/hd2HWzn1jWp822UmFotJu
hUQV+epUX9Y99tdJXQQwYAET0oqC9vm9kQ8xdhmSRUKi5srwtEnzmlvIhMlYoqSf
JO8iJcOVUFJdiYL9Uv+JsVnhIU4l8vSLwz7vhpHOJIwgR8AJOKcQ55+9H+jucqD7
ozeXdsOxiVjskuHH5Qv8UYHXqtWrMI+PL8CIFsGw2P75NgUEW7UXWHijCsgC7dqC
vAe6ya6sEtZleXp1eE1k93sAW6CVi1ZyCOGweZBeJyUE9TqnjHzWJJWwr+4gfoii
0Iz93Q29sVVaLlPyT0LTlELr4+bXtDL2PstGn5NHxhGxW2yyG2gLkt5ua3lOlDmx
1rWK9TFElvt2Of4CXSUU/XXvpMYcDjsRdL7miZ8rwFVyh66aIIU=
=l737
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
