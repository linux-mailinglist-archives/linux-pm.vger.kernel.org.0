Return-Path: <linux-pm+bounces-36981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485CCC14FBD
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 14:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309BB3AEFD4
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF80218ACC;
	Tue, 28 Oct 2025 13:48:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D2224B1E
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659293; cv=none; b=a8Q+NqF48rH7w0CZ1XrTEDZ1uVGg6A0gs2n3h7SiyV9scn05iQPhYzjC4YTr1bvKMNWt3imjhG4BBUv/p22EDx+MOQe2KWQ9qC6T3zTjYV4kqSBlDIkNqPiXTejgbTbq1PdhYTDdMLC6zhErim8jycavBkdh/bTKOnlhMuGaq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659293; c=relaxed/simple;
	bh=mo9APOFetC+o4+E2vl8lwuxRbZ/PNfLE6Ac+ecHV1dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVwvbMZKUkvWwmQLer0zk3ax0vcW5QeAbDlUDlWPbnGSYnKGcDrF7SciQ85lR7diIqVFA4xCTBLDGkuyX2b5NwU1vVZ0IbFp2Jt4Lpih9Mvq7v5xqPbI6MRkBD4n9lvBJYCgUJM7Oe0NRSIskKPysqT1U0+t8zlFQByAEoV36hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63d0692136bso7002258d50.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 06:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659289; x=1762264089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPMFTXsnoNZjm5dyqceKxk4gXVUdwjZcnDXHEFYHIA0=;
        b=sLjlImcUYNsPh5JfozYKg1AWesSlVPfZUGYcmOzcBI0wpGtHZgtbPzNQOX73lQyIDQ
         wN8mOaH8a+Eb1Q7chEDJ0dm7/D3Pe8SyIov7Smw4jZ1shncHpoPi4HGo8xPIEhuz/gN7
         p1bgSZUAS/vsUWt1iwF5/MQh+urwXTQkP2/molqIqFODt6xzW65mFtT/GFXyYd/fKd8d
         hteYMz+q3Fe5Vjwlt8Xr0+5FhuQ1Q29zxfGvrFUnah0f55CfUIG2XkwDQzIp6IdoZiLK
         j3iYycK2ZmfDXWq7IhGT1jUzKocboQdx2zAVhOyUyRoqKPjHod8gd3wWVaHK6/mLfNIR
         4F0A==
X-Forwarded-Encrypted: i=1; AJvYcCXY6d7CUn965HwFAuMAFyWpN8NN9U9kMlPJO6cVGcakLDU2h+vp6KzegUvTQYj07XvuI96+68s21w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzol3iWchJcJxk1/HgAp0wc7RCUiyYyLIPiQzsPDq9+l5+o5e4q
	BwKxZlNuy6o8Oz5uPq4UodBgNC7bDSwTWBcYqUUbl687AuyBOkoAeXua3ETFTUsjMDWX57gqrLF
	ojNOzEjrYE4HGYnBbC4P9Zr8+cFsMfLk=
X-Gm-Gg: ASbGncvstOPTkh1KO7bn5KyyWhvDmUd7f4UndipIRV/qDr3ug21lQTE0u77EbRqTM78
	Y8qjfZ6bNlhzxHta6P+XWWxXTNFyvcwZMhD1kBgbPu62OBm1FpvbLsVgXbKhW3ffk6W1SKftaqZ
	0+HFbfmMJ/4bHoUrAAMh4LVhYEcdKvaCXL3ToUevSPII3GA6X7CSlKhbfoXCNAb5jAXuf0zSm8N
	SGOCZnsgckqU8aw48JOpMYVQHvtHQz/oFU0fzTyG5QUTSFbpT74aoSxGxFBUfLZ9LfiK3DuKw==
X-Google-Smtp-Source: AGHT+IEpad4qjzXZnnPUSnxLHEvfwEEW/p4NMzrGRe+eVIllVRD+MMw8/uUDVMbqy8K2DcaFli6aaeVoXMtxDLr8VQw=
X-Received: by 2002:a05:690e:42cd:b0:63e:e9b:6220 with SMTP id
 956f58d0204a3-63f6ba95f0cmr2455437d50.47.1761659288840; Tue, 28 Oct 2025
 06:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915062135.748653-1-zhangpengjie2@huawei.com> <651ffa3f-9098-4d00-877b-d22e3e8cd64a@huawei.com>
In-Reply-To: <651ffa3f-9098-4d00-877b-d22e3e8cd64a@huawei.com>
Reply-To: myungjoo.ham@gmail.com
From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Tue, 28 Oct 2025 22:47:30 +0900
X-Gm-Features: AWmQ_bk23k_KI096SoA9euoBCAKpEylPGoxdr43SmVwRmbr5t2KsgoFftr8vmtY
Message-ID: <CAJ0PZbRsH6DcDKHhYGDktg-zejfWafnRR-DHrp8Zw89ervh2HQ@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: hisi: Fix potential UAF in OPP handling
To: "zhangpengjie (A)" <zhangpengjie2@huawei.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, linhongye@h-partners.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=EB=85=84 10=EC=9B=94 27=EC=9D=BC (=EC=9B=94) 11:28, zhangpengjie (A) <=
zhangpengjie2@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 9/15/2025 2:21 PM, Pengjie Zhang wrote:
> > Ensure all required data is acquired before calling dev_pm_opp_put(opp)
> > to maintain correct resource acquisition and release order.
> >
> > Fixes: 7da2fdaaa1e6 ("PM / devfreq: Add HiSilicon uncore frequency scal=
ing driver")
> > Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> > ---
> >   drivers/devfreq/hisi_uncore_freq.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_=
uncore_freq.c
> > index 96d1815059e3..c1ed70fa0a40 100644
> > --- a/drivers/devfreq/hisi_uncore_freq.c
> > +++ b/drivers/devfreq/hisi_uncore_freq.c
> > @@ -265,10 +265,11 @@ static int hisi_uncore_target(struct device *dev,=
 unsigned long *freq,
> >               dev_err(dev, "Failed to get opp for freq %lu hz\n", *freq=
);
> >               return PTR_ERR(opp);
> >       }
> > -     dev_pm_opp_put(opp);
> >
> >       data =3D (u32)(dev_pm_opp_get_freq(opp) / HZ_PER_MHZ);
> >
> > +     dev_pm_opp_put(opp);
> > +
> >       return hisi_uncore_cmd_send(uncore, HUCF_PCC_CMD_SET_FREQ, &data)=
;
> >   }
>
> Gentle ping on this reviewed patch. =F0=9F=99=82
>
> Thanks!
>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

PTAL, Chanwoo.

