Return-Path: <linux-pm+bounces-7931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE38C843A
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F323B22304
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 09:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F3C1C294;
	Fri, 17 May 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTPI1yah"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61552C68F
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715939464; cv=none; b=AuM0PQeDCRIIModj9LlVPq4ENEwUr2YTGr+NH8BnlhAXDp9KVfN3o9p9MwGv5h4lErzvlOKVK6XupMPV4juONc9LH1vpOKvOgu3MR1rPz+NcSWXVXGQCafF9Q67HrqZOQV0dHPdJ0cgDFDiG2ItzGuRR86R20lXo7WxhlGRkJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715939464; c=relaxed/simple;
	bh=umr6x9k3m9I3EaMQpZAla3HYIuVCB+b9qLGvmHWWLBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBfdOVvLmFXGAzYkAAhVBjfAvbM9CEMBVIHnDpjwOCTA4tae+9z48/0n7+GFOgc4wEvLElxrGtpu1AZsV9TYdUEL/Bs26CZd8UHNtcdVpVcIKPB/d/klY3ltIK6eDnq+hTJ90AxfJiWcl7qW574Ca6Web9Ufj07h2HPf55h5I2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rTPI1yah; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e428242a38so23119501fa.2
        for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715939461; x=1716544261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2L8RSK1UXgr12jXF9ubAdgAxLZaIH1liHhgWTNSlMsQ=;
        b=rTPI1yahKw340MOh4dMjhEOumBv0MWiuBtO2W5foCpzRzHU3y8UvXclEBXMugf3XrL
         Fr/y0bSFF4gcc9doIAFEQG+I0yY7iH7UUVgtF+c9qSp2UeMgFJQ3dlGQXiO6XFJbeZG+
         t4YnbNLaNsQt8+NMvQdQk1ik7Zrlo1A76KOnKbQ0sXdNhuteDIgfESCk0t8/+P0hB959
         /Y31YEDuTIiPFjv5sjaei1Ev46H/PPnpTebcv7T3tAlK7wb3heAxJ/nc+Iz8R3NUyYgl
         7stW1aM1gWNbjlPrDcYSJKU+UMvTyGzvNZ5cJAT/xexD3419pUI9QDVIR/fS+HUQkVkM
         F3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715939461; x=1716544261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2L8RSK1UXgr12jXF9ubAdgAxLZaIH1liHhgWTNSlMsQ=;
        b=thkcOGa/BF0c5GsGpB8+DuS0TA+Cu2Atwr4kIR22T27K9oyWDkKEE4Nguhgx86O80F
         zZejI5aMCEEWWSBJGc3Pp1Ij9RyYIC8GSdsWXVIfasA7XTwS+opTsplcp9Mktg6FKSiD
         oI/o7/x+BIA8s0k1AZWTpTQwVS4AIucU7DbmVRJ1iU3NpUhXbBVjEL3uvHDml/7Z7/Ys
         h0nUD1xmOnkjfRfeZcyW1fv+ek0x+4Q8fBLQ4FDVwvXEY8U0cwIJhD3yFhjhST+YOfKj
         vfhK4fcdNxlSRzKHPoPrLjmQhYzEE/NaR7pyppDHQOKa/z9VICnijffQC+hqJdYUmvpP
         v85w==
X-Forwarded-Encrypted: i=1; AJvYcCUKtYlwuhJQhgJ/yWl+/nNjR+O9UjjXFztSO0TkQ5wc7SS50J9AJn+mSdfwaniJFXn7P2W2DR+ThdpazSlZPo+CpuJ+rKZS2eA=
X-Gm-Message-State: AOJu0YzwRXhw+UGONs1yFIcAbEn6fQjAmjTr/ZY9WwpZBIp9ka9JL1/6
	nglRBxphrvdgHA+VKEL1GDzusXMxllmr3+JhOU8BRLv4PQk7PcaZ4wCVBO94OMQ=
X-Google-Smtp-Source: AGHT+IE/i6HrkK9a32WnwA2ipdftjxu8Y3Zxt+EzO3KENJBumi5p2N0H8j3JeSeqai45ufNVMCWpLQ==
X-Received: by 2002:a05:651c:546:b0:2e5:4c78:1227 with SMTP id 38308e7fff4ca-2e54c7812famr187118681fa.31.1715939460955;
        Fri, 17 May 2024 02:51:00 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cfbd73547sm147700966b.171.2024.05.17.02.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 02:51:00 -0700 (PDT)
Date: Fri, 17 May 2024 11:50:58 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Icenowy Zheng <uwu@icenowy.me>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kang Chen <void0red@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/2] thermal/drivers/mediatek: fix a regression affecting
 other subsystems
Message-ID: <6b643d19-bdd9-4c35-a775-b8e3c21b75f5@suswa.mountain>
References: <20230529162056.3786301-1-uwu@icenowy.me>
 <40546a57-27ac-8bf9-a2d8-77f7d4ab4aad@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40546a57-27ac-8bf9-a2d8-77f7d4ab4aad@linaro.org>

On Tue, Jun 13, 2023 at 10:44:51AM +0200, Daniel Lezcano wrote:
> On 29/05/2023 18:20, Icenowy Zheng wrote:
> > In the commit I reverted as the first commit of this patchset, the
> > of_iomap function call, which allows multiple mapping of the same
> > physical memory space, is replaced to calling devm_of_iomap, which
> > registers exclusivity, and on my system (mt8173-elm), preventing display
> > from working.
> > 
> > So I reverted it, and to really solve the problem that the original
> > commit wants to solve, I read the source of auxadc-thermal and realized
> > that the address of these two memory blocks are not saved after probe,
> > and they're only used when initializing the thermal sensors. This leads
> > to my final fix, which is the second commit here, that adds of_iounmap
> > just to the probe function.
> > 
> > Icenowy Zheng (2):
> >    Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource
> >      leak in mtk_thermal_probe"
> >    thermal/drivers/mediatek: unmap foreign MMIO after probing
> > 
> >   drivers/thermal/mediatek/auxadc_thermal.c | 46 ++++++++++++-----------
> >   1 file changed, 24 insertions(+), 22 deletions(-)
> 
> I'll apply only the revert and let you revisit the patch 2 which could be
> improved.

What's the issue with patch 2/2?  It looks okay to me.

regards,
dan carpenter


