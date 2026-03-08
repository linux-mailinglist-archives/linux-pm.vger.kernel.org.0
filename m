Return-Path: <linux-pm+bounces-43916-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM8bHgAtrWnlzAEAu9opvQ
	(envelope-from <linux-pm+bounces-43916-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 09:02:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE24222EFF1
	for <lists+linux-pm@lfdr.de>; Sun, 08 Mar 2026 09:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8BB6301BCEB
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2026 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAA0355F4B;
	Sun,  8 Mar 2026 08:01:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C326B973
	for <linux-pm@vger.kernel.org>; Sun,  8 Mar 2026 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772956913; cv=pass; b=cT7Iqgx2X8Mvv+AmIaZxMGt6Xy19vjewmAFFxt5Sh0aD9q8dOuxBgajNTO95+iyp8BSEcWCq0/7CLgonau0wtWvceIYpVBj3vkpQjqAGsMhbXp8flPE4x9kCGXaHjvnjcQJgdr4txcND9dAB5rT8QrZms41ARXwJuMVKud09mDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772956913; c=relaxed/simple;
	bh=e+JWpxUFxincKrOFEbSflBir7bHI79X8q1wNTBKiq+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rreJBBYFtMY9qg7qZ5z9e5jZo6NZZjYFziHwVrH+Dou0+UvEk7vie8GjyyrP5AkEmNHAiE/2JLiPoPlqr6c572j/hpkzX7TL8RpmcUcqh5ZeqvUz2dCzDGFySarOW18hiF299MHPEYdgrUAOBfFGwKPwP7unCbcBt/ZWx1hjH+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7986fb839f5so92283347b3.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Mar 2026 00:01:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772956911; cv=none;
        d=google.com; s=arc-20240605;
        b=Qr9lI7ogG8ASGe7hBw/Gp2s7yJmOuZQ6+H1agqcPRBGNNjbeqhJyLRMKAPF1F/8qUg
         4GW1xEU8dGfDtG+jK5Q6S35zEAUHz/yqYTePrLbnJHdjcZ0z9TNWZc4irB3NWHTaXVmv
         suUwCkXeI9a+pwfW5aiWtq1gLbiT2lkuWDkDw7oD+iEHL4FOP9sRW8o9Dhp3K3LUkWVq
         OAmY/5dCAKxkYYkRa/TdBe3d3wkYw/p/L8GupiRKVc/pLbUJTQez8+uBM51GhOdBLcqF
         x1Bz0DTkROINFeKK/MAabGu8cdMzjM3olZwl96UGX+EIBLce3qqWHwzfXwtj2l3+7gHV
         ev+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version;
        bh=GOWP6zSnxcF+tsFTisgMeGRm8WIPpUWzrAQyegG9FEw=;
        fh=rBSCuoR4dzbmFh4cx1Irry/1LtF7H4OC85j1i0+9vPk=;
        b=a4rN8vYEG7lJA5xsp/iCv5db5MpyjnrVuWnjS+mdXZdNvzZ9h4x3oNU4al++LRPhRG
         nertIkZh2612rDycqAAfTOEVz1vFswgtIyWjTHMaKWdnTS6dR63SSf0T42cHE8MF7a4J
         N0m6LqjYiVdnhGdhQG7ieeqCQPLBuQoZzNdhvVSwjh3G6i9gVCY5HXxUCWePQkUliD++
         nFbw4w5c+7oyZO/gYO0NsVdM265qn5g9wvLAVrh1r3vOcxpJV5HLvL6sgBio2F35Rz4/
         ybpderh8HCaCDIUNMu/ax1mxwASVsU/+g/Z+NJeG3zs1v2lYugbdgl0M/divegEm3qTT
         Kxjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772956911; x=1773561711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOWP6zSnxcF+tsFTisgMeGRm8WIPpUWzrAQyegG9FEw=;
        b=j0FdIFchezburkiHTEDarNwIV4EmQAwCuwHoINzTtIyTe8rBN6Y8nXGCG08OUMetS5
         VtJ0M7dQ4KSAk4ZUqocQ3RQeYtMk7iFRqWm/MJfDfZvC8sJCYLDU8Sq5bVtjvOkDsK2t
         71YTgMpWLum7SV1GOtnVyWW28iPpl9dVW7kJotfaMtrmkVyTIkqlT5UNC0P4n7qTRyfZ
         D0VN20/Dx/DuWUiYCLpF6+b/ItKSFgpYGDG2hLfiWM8AdF7q20bxtnTjlzFOOWB0k2ta
         bB/JK71rdYraV0UrSNA8I6I6RPH2QuYmtwkPm5+9AutmsTfty0CSeIoCh80tEG0AmaQ9
         DnJg==
X-Forwarded-Encrypted: i=1; AJvYcCX2FwHhqEDqYgVWxhJ5TL2gwW9/4alQsGxaTjz42IB6VpQiLn8BpnWpaTvYfAcLl9fJxEHAH+wAQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQthxSMrxUlLWt2N84XFLi9ZLxZNbqNCLVzJvbkNk175pdTsz
	mp36XCBEFIo6ec0zdP4buW6YQjQ8WHCAkXGkROOXCfngh//8TR1GyGmYWEgujroDxijUqK0PWsY
	5oX/rTJH/Q8V4F4BTzIlAEWqiiPakiCs=
X-Gm-Gg: ATEYQzwXwKUdIa4PxtCKKWycKOVvwpvUdFrvfDhCp70CEcn6qpdXgAakYnWpzZ3pq43
	21Jf4r0aVakIVxOodDVqNPQkEEp77lkPDTmvLd96NKnUsV7zhB0PxHZY1KhMPk4kEy/HhUepWEf
	edgB1PGXF3j5nRqoCWWwtCUYwPPTe0oCVZewLbmS++Y972kzx3FlP/Vk+1jEnA9QDHsRjwqCT2Z
	23En1CYlQr/lE5NmYe22CNThNmvapgpYAMpmreD9Rwfn+Ibz1ak7W5wWkaOW6h/Q1OtTA5mhHiC
	ilU1pZ5RsQ==
X-Received: by 2002:a05:690c:dd3:b0:798:6a6b:5af3 with SMTP id
 00721157ae682-798dd746276mr64700047b3.34.1772956910640; Sun, 08 Mar 2026
 00:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126185423.77786-1-clamor95@gmail.com> <20260126185423.77786-2-clamor95@gmail.com>
 <4b98421a-9e64-48cb-9726-ff34a5b9cc76@gmail.com>
In-Reply-To: <4b98421a-9e64-48cb-9726-ff34a5b9cc76@gmail.com>
Reply-To: myungjoo.ham@gmail.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Sun, 8 Mar 2026 17:01:14 +0900
X-Gm-Features: AaiRm53blAKzXa1-IVJRNtnVNQwzPeE9ufIH8qWoEmbaU5kj6Fs3pMXVHGeWD2k
Message-ID: <CAJ0PZbS6JhPOMNP3fB4biiu3b32jF-A6AMQ6M7usOEG0B88JJw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] devfreq: tegra30-devfreq: add support for Tegra114
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CE24222EFF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[samsung.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43916-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.168];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[myungjoo.ham@samsung.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,samsung.com,nvidia.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	HAS_REPLYTO(0.00)[myungjoo.ham@gmail.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

2026=EB=85=84 3=EC=9B=94 3=EC=9D=BC (=ED=99=94) AM 8:24, Dmitry Osipenko <d=
igetx@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 26.01.2026 21:54, Svyatoslav Ryhel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Lets add Tegra114 support to activity monitor device as a preparation t=
o
> > upcoming EMC controller support.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >  drivers/devfreq/tegra30-devfreq.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra3=
0-devfreq.c
> > index 8ea5b482bfb3..fa83480a923f 100644
> > --- a/drivers/devfreq/tegra30-devfreq.c
> > +++ b/drivers/devfreq/tegra30-devfreq.c
> > @@ -963,16 +963,22 @@ static int tegra_devfreq_probe(struct platform_de=
vice *pdev)
> >       return 0;
> >  }
> >
> > +/*
> > + * The activity counter is incremented every 256 memory transactions. =
However,
> > + * the number of clock cycles required for each transaction varies acr=
oss
> > + * different SoC generations. For instance, a single transaction takes=
 2 EMC
> > + * clocks on Tegra30, 1 EMC clock on Tegra114, and 4 EMC clocks on Teg=
ra124.
> > + */
> >  static const struct tegra_devfreq_soc_data tegra124_soc =3D {
> >       .configs =3D tegra124_device_configs,
> > -
> > -     /*
> > -      * Activity counter is incremented every 256 memory transactions,
> > -      * and each transaction takes 4 EMC clocks.
> > -      */
> >       .count_weight =3D 4 * 256,
> >  };
> >
> > +static const struct tegra_devfreq_soc_data tegra114_soc =3D {
> > +     .configs =3D tegra124_device_configs,
> > +     .count_weight =3D 256,
> > +};
> > +
> >  static const struct tegra_devfreq_soc_data tegra30_soc =3D {
> >       .configs =3D tegra30_device_configs,
> >       .count_weight =3D 2 * 256,
> > @@ -980,6 +986,7 @@ static const struct tegra_devfreq_soc_data tegra30_=
soc =3D {
> >
> >  static const struct of_device_id tegra_devfreq_of_match[] =3D {
> >       { .compatible =3D "nvidia,tegra30-actmon",  .data =3D &tegra30_so=
c, },
> > +     { .compatible =3D "nvidia,tegra114-actmon", .data =3D &tegra114_s=
oc, },
> >       { .compatible =3D "nvidia,tegra124-actmon", .data =3D &tegra124_s=
oc, },
> >       { },
> >  };
>
> Acked-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: MyungJoo Ham <myungjoo.ham@gmail.com>

--=20
MyungJoo Ham, Ph.D.
Samsung Electronics

