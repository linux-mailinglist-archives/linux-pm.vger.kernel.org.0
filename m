Return-Path: <linux-pm+bounces-6096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D292589D24A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 08:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12727B233B5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 06:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B53B76413;
	Tue,  9 Apr 2024 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVAg4r6F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7476058
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643744; cv=none; b=mYkSbByRqGZsj1N4z4u+VODuwtoX4k2hr58clWeOZEdZ+TGkpvFtPKjJgfHhjxTQFjs+YiOlvm3YZaDfsQcMdtmQsYGc1Ac+7YNyncgWTN20/vEoj/HgYHx1/nVug2RwYbG4cUpYN8uMHNghJwi+M4c3TiXdApJIxglXf9OYy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643744; c=relaxed/simple;
	bh=y/N4w4ACVX8+rwzurXt0wPOGs6PInCUVXqIgWDsm+HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ+B+2MkgdCvnEeUpofJOWtZNrI3jDn/QUzHVEejuyS25RwpFQRcl/WnCXBYQW9bwVIhYySQApIpRtZjab3uLMyEN0Uk/rTTlNykLLWsL1/yZoTwv3lWfjIfetnepB4AscPTv1I/lsvzx7VRZSCHVppb1LpQWKL5ksO3ahyXgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sVAg4r6F; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a47385a4379so1146805466b.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 23:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712643739; x=1713248539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UMDYO2c6oxyg4uLYpkx2s2QjYRlbgcgKpJOA25y7Xcg=;
        b=sVAg4r6FL9E4SZ+4X2QmfJEMURmaH5I/b6xZtgQLypadhicxgXhJptvwowhyXSu9rP
         8gxJ0rLdWMeGpEQFu3vA3sZJwkLVGrukNEGpxmde+odqx7ZYWHoZnPlb6HeHQeFIWXex
         2MSlIMY4ulEqu2gkIsIN2c+OEn8uYmjev+yq3GqpgslcxrE+RynWrfRqmkiZWmbKuT8d
         mnAVByivy8CzoKz2RsF8TnE5kIXieaRLuEHY2Yl45sX5IS8LsHlkBmzDjoBKRQsSpHyT
         j79VcNKbbHm3DtZD0LfZxgcOJf0+EpKw+yxOsRPO6F9G2Ru61HVzmfYUb+w8rGfl/ICQ
         cJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643739; x=1713248539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMDYO2c6oxyg4uLYpkx2s2QjYRlbgcgKpJOA25y7Xcg=;
        b=lbj2JuLPO5otJqzBX8HccFefJXAI/ay8RqdH/7nc5Drc+qYoo0iFXF2AyWo9/wZ6qG
         9Q1S7zaW/4af9m/juYWSISHBqOPLl8XveXZUemqLmzGQw0NwqLEOhezeTp9CQNDw5UGr
         llPIW+eHDU3Bnlc9CeBEy6L6izPWRUdZfyyaRSFLoHZ+G4miAh+qOpKrEiyK3HxQmxRR
         3be4iYBtryNeJ1FTVNfTNQSEDkiG0cBTd5sJJrYjEbLhIU0T666K+yVlNyJR+35gTFCL
         eJxtmtlGfasmnybc8aTT8EnW0iBVCi+t0l6CAiCzbdyL+rPFmuqfcdTbIsvVdaOGyoJw
         LPCg==
X-Forwarded-Encrypted: i=1; AJvYcCUIeM1yQfYPb42bUQe+8Q5lvtggFyxkMA5BNwrsaZwZRJAp+VTYFBgb9cOYKyP3WjhnRPiqR4io7HygHOKSxTXuIGlqE9+4lZs=
X-Gm-Message-State: AOJu0Yz9NJ34/rWo+IUTYzteMjor+sbz1O7RlQVHHeg3iBbHyTKWKG5M
	UNycFCwiJnV5zFbLqFjIkSbI5jC2PRyVpST/tbFwI70hDduALkWVHGBkuddmfYI=
X-Google-Smtp-Source: AGHT+IFezcxylFThCkZ5dq6o+jnfozGQsIp94NHvIm6eTu25O92P3DhT+nJlYrPygKuAeOBrFXddww==
X-Received: by 2002:a17:907:7203:b0:a51:d48e:52a0 with SMTP id dr3-20020a170907720300b00a51d48e52a0mr1969227ejc.27.1712643739522;
        Mon, 08 Apr 2024 23:22:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qx25-20020a170907b59900b00a46caa13e67sm5252758ejc.105.2024.04.08.23.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:22:18 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:22:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] thermal/drivers/mediatek/lvts_thermal: Improve some
 memory allocation
Message-ID: <483b8e9a-26db-45c8-ada6-e39575760c51@moroto.mountain>
References: <42a87fb9837f1760d1ad4eb7162a7536785dc6f5.1712520052.git.christophe.jaillet@wanadoo.fr>
 <8cb69f245311a348164b0b5ca3dbc59386746035.1712520052.git.christophe.jaillet@wanadoo.fr>
 <d97f2a57-d318-455b-a860-8bd7972c8aaf@moroto.mountain>
 <4ebbe227-38b1-4a1c-af34-9ba7bdfecad5@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ebbe227-38b1-4a1c-af34-9ba7bdfecad5@wanadoo.fr>

On Mon, Apr 08, 2024 at 08:41:26PM +0200, Christophe JAILLET wrote:
> Le 08/04/2024 à 10:09, Dan Carpenter a écrit :
> > On Sun, Apr 07, 2024 at 10:01:49PM +0200, Christophe JAILLET wrote:
> > > diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> > > index 3003dc350766..b133f731c5ba 100644
> > > --- a/drivers/thermal/mediatek/lvts_thermal.c
> > > +++ b/drivers/thermal/mediatek/lvts_thermal.c
> > > @@ -204,7 +204,7 @@ static const struct debugfs_reg32 lvts_regs[] = {
> > >   static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
> > >   {
> > > -	struct debugfs_regset32 *regset;
> > > +	struct debugfs_regset32 *regsets;
> > >   	struct lvts_ctrl *lvts_ctrl;
> > >   	struct dentry *dentry;
> > >   	char name[64];
> > > @@ -214,8 +214,14 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
> > >   	if (IS_ERR(lvts_td->dom_dentry))
> > >   		return 0;
> > > +	regsets = devm_kcalloc(dev, lvts_td->num_lvts_ctrl,
> > > +			       sizeof(*regsets), GFP_KERNEL);
> > > +	if (!regsets)
> > > +		return 0;
> > 
> > I understand that this preserved the behavior from the original code,
> > but the original code was wrong.  This should return -ENOMEM.
> 
> Hi Dan,
> I don't agree.
> 
> For me, this memory allocation is of the same type as all debugfs functions
> that we ignore the error code.
> 
> If it fails, it is not a reason good enough to have the probe fail. (anyway,
> if we are short on memory at this point other errors will likely occur)
> 

Huh.  It's an interesting point.  Fair enough.

> > 
> > > +
> > >   	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
> > > +		struct debugfs_regset32 *regset = &regsets[i];
> > >   		lvts_ctrl = &lvts_td->lvts_ctrl[i];
> > 
> > The blank line should come after the declaration.
> 
> The blank line was already there, and in this file, it looks like the
> preferred style (even if not completely consistent)
> 
> Let see if there is some comment about 0 or -ENOMEM in case of memory
> allocation error, and if needed, I'll repost without the blank line.
> 

There is supposed to be a blank line after declarations though so I
think if you re-run checkpatch.pl -f on the file there is a checkpatch
warning now.

regards,
dan carpenter


