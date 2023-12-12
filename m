Return-Path: <linux-pm+bounces-999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A6580F53F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 19:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D1D1C20D55
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E697E77A;
	Tue, 12 Dec 2023 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBhZqSFs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1172ABC;
	Tue, 12 Dec 2023 10:09:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54ca43031d1so5698597a12.0;
        Tue, 12 Dec 2023 10:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702404597; x=1703009397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzHpbohFT6LpAWNTUe1hh6CWPa5rN3o0qmOFe9ThREM=;
        b=HBhZqSFs4+SVUCbqMTOEmXgA7KeSlfrsdPNA4RDwgvjWdoNjPvRoWAD+0aN2SLKRK/
         bT2gb3v7Q74k5ePmzOYb+zbQYu2qFB7oPv5V2fFjCn7JGypEQkE/GMXi/aRbdT+BwMr/
         gIH070wVKbsEN0Ol1e2kmc+hOZUUmCCG5DVaD/xPujjtQfRonwpWzTwH11FM/FdKdJjZ
         DzkK3kBYBSxuMssXCyNCH04I68m4kVp7FMmNy8LQJhnF4dmsrpCBG28E1xe56fLy8bS+
         nvSmU2pkRBFvZCPUIEGzYDvNGSf9J9ieb9Ik7Qm3VV+NIl1Ahee+AJl1YqfCmnJhV2y1
         XOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404597; x=1703009397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzHpbohFT6LpAWNTUe1hh6CWPa5rN3o0qmOFe9ThREM=;
        b=Wfo5q+ocHKUwim34fb4HKFRtOu14yuesPFUUHPtCzj7ahUI+wNHnWbU4ZAuPMGeV/Z
         0sBUndZzRDEEeWhvHWmsSMaksBipVWYCHCWhlXIPM2e9JwZhQ5L5JIWrGXetBbZDJ9Hn
         G8XQo/qJk7jT8OcfPt6wdjqmyuRt5Erd+vyTiCrycG3gAxkuzE8tpGfybHhHQAdZ90Be
         8LjhSGB6hnDkJctAhnsfIob20FYVmXqjiBqwALneOgIF23rN9C+/WdO8ktsolO6cqNKG
         Uji8vsoRYF6sNRak+/2yGvq1nfotKY2MCGPOoTIBUuNe1emp2HkuMJuVIebo41NL7jDO
         BInA==
X-Gm-Message-State: AOJu0YykG1mWFHcxdY1stj/GSxiaRMdaXlXXwA1Sj6KA95JPAiAIWkVs
	9Mv5McnIt909qDgmkUdurgypmEqHEG6hBZDcOPg=
X-Google-Smtp-Source: AGHT+IEJ+S2gVNDukxKxZq7wUSERI+JIQpfaGwh6jo/cYSszkFlbTba+OH3MZMwKSNWFKwcqQo8KEwSOpUZF6Gy8G3E=
X-Received: by 2002:a17:907:7d8b:b0:a17:63b1:42a1 with SMTP id
 oz11-20020a1709077d8b00b00a1763b142a1mr4497018ejc.25.1702404597170; Tue, 12
 Dec 2023 10:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128005849.19044-6-andre.przywara@arm.com>
 <a14fb458-caf0-4a4a-b76b-c2503b0840d2@gmail.com> <20231211000528.57cb646c@minigeek.lan>
In-Reply-To: <20231211000528.57cb646c@minigeek.lan>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Tue, 12 Dec 2023 21:09:45 +0300
Message-ID: <CALHCpMjz4YiE_=6Cxq7RqF_3qPaw8UCA=6eLy9ZZuofRhr7mcA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] thermal: sun8i: add support for H616 THS controller
To: Andre Przywara <andre.przywara@arm.com>
Cc: anarsoul@gmail.com, bob@electricworry.net, conor+dt@kernel.org, 
	daniel.lezcano@linaro.org, devicetree@vger.kernel.org, 
	jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, lukasz.luba@arm.com, martin.botka@somainline.org, 
	rafael@kernel.org, robh+dt@kernel.org, rui.zhang@intel.com, 
	samuel@sholland.org, tiny.windzz@gmail.com, wens@csie.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 11 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 02:48, And=
re Przywara <andre.przywara@arm.com>:
>
> On Sat, 9 Dec 2023 13:44:34 +0300
> Maksim Kiselev <bigunclemax@gmail.com> wrote:
>
> Hi Maksim,
>
> > Hi Martin, Andre.
> >
> > May I inquire? Why do we need a separate sun50i_h616_ths_calibrate()
> > function? Why can't we just extend an existing sun50i_h6_ths_calibrate(=
)?
> >
> > At my glance the calculations in both functions are the same. We just
> > need to handle a special case for the 4th sensor.
>
> You seem to be right, they are indeed the same, just written slightly
> differently. Do you already have any patches that unify that?

No, I don't have any patches for that yet. But I can do it if you told
me where to
send the patch. Should I put it here as a reply?

> I don't know if Martin or I find time to do it this week, but we could
> also optimise this later.
>
> Cheers,
> Andre

Best regards,
Maksim

