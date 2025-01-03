Return-Path: <linux-pm+bounces-19919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B87D1A003A8
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 06:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001081883AFE
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 05:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F21B219E;
	Fri,  3 Jan 2025 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjyUiju2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9221B0F1B
	for <linux-pm@vger.kernel.org>; Fri,  3 Jan 2025 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735882735; cv=none; b=CmLhWFjw0wW6nFocWoKkVPMWmdx3XGAzBLozHXIBZdADIApTowxPQy3pg+mLf2HpCd4QwRO/zB6j8LCKRg6bGrPREllC0hzuAhKH7gYsstGTyd5VUSgUhL4mOmrI1Ze1Un78TvUAFLGtaztkyFNAzdqQHHkKjy/4eYvBKjnD88Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735882735; c=relaxed/simple;
	bh=XTewuUNQ+/ESgzDVGNQhvgCh25cMGfsFj/3A69tDp6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcxY378/HfBLGfqyVHBpMKXjAyFaidWflgU9Q6t23w1v9apcaQEyEhqLKX8rEU+PbEoefkWjYfuHI+bYyU60Bs0loXyqKaKv4VZUiYgXdBufqoiZaPazmUBN1qRzz5jQEsCVhi1jJrQnf2XOGJiac8Vxy7Etm8GrdsV6m8Tv/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PjyUiju2; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30219437e63so138555411fa.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2025 21:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735882732; x=1736487532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nh6CMd7r1T+hytaykBZTXDKLZ482z8ewIFxQcxwOIrc=;
        b=PjyUiju2+93QaTOGjTiRINGC5m02tlUUCiIedkl5uIGmro+a7rmp6pQXXalqhLiR9I
         e5O7wO+y/joJltHnDyu/QQucm0mFv7JakKcyB9/VpjiGeAkA8b0aoiRdMXoi8Kw/wxSG
         knsbzkS1rnEtcJ46Dx1APZ697z+zIY5x4Tuj62O5f9ZqbXI1ynuTnqipd69w/QTC3EYb
         LbftxjvSUu+5VapUmEFh+WeYMFJ5RpE7W7/wKTh32adNu0YEGWydy1c/+QTTGgBgEJNE
         SX73WAbAoxFTvqp3nnSg3hCIKC7UXe70/JH4XAldURnbj9wNzt2JINFQ6k43TED8PQA0
         1q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735882732; x=1736487532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh6CMd7r1T+hytaykBZTXDKLZ482z8ewIFxQcxwOIrc=;
        b=hD70/wJhfV7IH3lhhyt9K0PImKZIWRSmo22CNqRIvYipuKJk3Xw9oeOAUZdvZNqcJp
         Y5a7+vhKAAB8JObb+dQESXHEtR+iPIAzzlYVMv5JW6i69en9N4YJEbSriQl/qQcNKYpV
         XkM0zD7kiGuXkL2wzkpjcKueFShjsbvidPlzVVTSLfUQAxRP/4n3Z1ujOjbjRxmCqN4W
         FJpJ6J9KULIxPTFNWF7ZU8L0hfQZsBWsZq0RQkBZ5HePGwv14xr8pMBS39C4K4TWaW/0
         CluILrbhSXtt6f9j0dm+FjS+jykdOYzn5vgXA9v2M+rLSUoMahKOnfaTzyP5VJNFZQ/2
         CjUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6K4RkKG24eTwyMwe6p/D8+O/WGvdyTQd5I2g5dPrft8DJCdnzM5xIe/RZvcdY4ky7YvSx53shbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DV6YoDR9JEJSnNkP2xF1a3GykGqHbSRWxdhgAwPQs9ibypNa
	pU03UGba2xEzGWw4fUONM9OyFrvtUB2JlPDOpmA1O0aK5ndFt3lxI87X+/OyXCY=
X-Gm-Gg: ASbGncv0xwKuUoucFzokzATwjkv/Vonp6DMPiR+O/vFsvXARLNAEhhioYCnrXdRKCXk
	kkhpMbqidRsNgPboUFed/dy1JDpidPs/DtDCqDqsPi1uGoKwTNqygEihwhts4xPa3m4bx7CnlFm
	zMyrKHKn2WCqVyrRGDmBu8O8GtHE0Q2QNYPVuqbuDZJZP60+9vRmOhGffl+wDwfw99GP7odjKsc
	5+2o3D4s1s735StqnLiRhb/eVTHhBTqA8mtbndO+g/Tw0cPaQlYeRC7k7QoCkMANTA88qfxcfoQ
	jrKA2vi8jaYAdvUAolr6eMGQADCBaxPj/uaB
X-Google-Smtp-Source: AGHT+IHmLh+NOber4nBw/SsreQFdAIZQKPzTuuOcd6i2VGjx3RMNWlFuyhwgzubmzrvX31fOVuwr6Q==
X-Received: by 2002:a05:6512:401b:b0:540:2247:ac4e with SMTP id 2adb3069b0e04-542212e1035mr14142710e87.7.1735882732124;
        Thu, 02 Jan 2025 21:38:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6c60fsm45363211fa.24.2025.01.02.21.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 21:38:50 -0800 (PST)
Date: Fri, 3 Jan 2025 07:38:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: quic_aiquny@quicinc.com, andersson@kernel.org, 
	bryan.odonoghue@linaro.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, heikki.krogerus@linux.intel.com, 
	ilpo.jarvinen@linux.intel.com, konradybcio@kernel.org, krzk+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, nikita@trvn.ru, platform-driver-x86@vger.kernel.org, 
	robh@kernel.org, sre@kernel.org
Subject: Re: [PATCH 2/5] platform: arm64: add Huawei Matebook E Go (sc8280xp)
 EC driver
Message-ID: <uqr2hibbl4krkseeal6shmcifctrppimk4tr3y4i64luqpslsq@q3mz2ppencwl>
References: <1dff7a78-1693-45d7-8ee3-357b33848595@quicinc.com>
 <20241231074437.239979-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241231074437.239979-1-mitltlatltl@gmail.com>

On Tue, Dec 31, 2024 at 03:44:36PM +0800, Pengyu Luo wrote:
> On Tue, Dec 31, 2024 at 1:00 PM Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
> > On 12/30/2024 6:44 PM, Pengyu Luo wrote:
> > > On Mon, Dec 30, 2024 at 5:04 PM Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
> > >> On 12/28/2024 1:13 AM, Pengyu Luo wrote:
> > [...]
> > >>> +     i2c_transfer(client->adapter, msgs, 2);
> > >>
> > >> ARRAY_SIZE(msgs) is suggested instead of pure 2.
> > >>
> > >
> > > Agree
> > >
> > >>> +     usleep_range(2000, 2500);
> > >>
> > >> Why is a sleep needed here? Is this information specified in any datasheet?
> > >>
> > >
> > > Have a break between 2 transaction. This sleep happens in acpi code, also
> > > inside a critical region. I rearranged it.
> > >
> > > Local7 = Acquire (\_SB.IC16.MUEC, 0x03E8)
> > > ...
> > > write ops
> > > ...
> > > Sleep (0x02)
> > > ...
> > > read ops
> > > ...
> > > Release (\_SB.IC16.MUEC)
> >
> > Could you please share the exact code snippet that is being referenced?
> > I'm a bit confused because it doesn't seem to align with the current
> > logic, which doesn't have read operations within the same mutex lock. I
> > also want to understand the background and necessity of the sleep function.
> >
> 
> I mentioned I rearranged it to optimize it. In a EC transaction,
> write sleep read => write read sleep, in this way, we sleep once a
> transaction.

Sleeping between write and read is logical: it provides EC some time to
respond. Sleeping after read is complete doesn't seem to have any
reason.

> 
> Please search
> 'device name + acpi table' on the internet, someone dumped it and uploaded
> it, in SSDT, check ECCD. I am not sure if huawei allows users to dump it.
> So I don't provide it here.

-- 
With best wishes
Dmitry

