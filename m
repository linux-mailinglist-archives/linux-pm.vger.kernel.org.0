Return-Path: <linux-pm+bounces-40779-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DF3D1C83C
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 05:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0C043167530
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 04:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6640A32862F;
	Wed, 14 Jan 2026 04:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ExYLN99T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650EC2D6E6C
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768366197; cv=none; b=sgOJCUBiA/56g75v7n9dot1/iB1tAO9SP89deNlDec/+bsyrgI3VEHqYuiHPkIB7JiGDRnyVjY/6YTx2l/ZRPbV2TIQJTtjnCfBc9vvOfpaNIBZRfvig6JAyEkdJDGHfg52l5Bl9d8MpHB8V5MYeCtQl7BxpqKka7E4/MWE2l90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768366197; c=relaxed/simple;
	bh=V/1j1ORswZY1aYqvHaFsO7Zm0k8k1k1lTRx3lDBeRXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMYaLhocU6RwaJQX10Hx5JlPqnOYLdu9EUX1KtNm1CZXTH6wbGKrAsrwD3ZaGI8zfylgabjfUosoMSVDAuUIhwJPQ2S8IgbWxKhbyzoxBx3W3KYH/H28pT/iQNhuEB1szyzxlRVLGnGrfsowc/s6HvSA0nK8Dwhyr6JXDKtijqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ExYLN99T; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81f3fcdb556so1921666b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 20:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768366182; x=1768970982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5OrhVo7pPk7eDVCRCc8EFrnL6xGq7csvkmXA9lcAHY=;
        b=ExYLN99TuWhTRRks/qYU1YfP6q8TOiX4SQl5oNlsVPxFZNoh60JXAVFyiZG/t1juxX
         Y3GCPNBczmQ6Brm3wtcFmB3b7QXaBAzfzcbP5WIAd4zyzeWnBs/QT0a5j8Bv5v/maahk
         TRiHolXHhmCRCgdhW7fe+9cPsqQfXgcBwuZcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768366182; x=1768970982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5OrhVo7pPk7eDVCRCc8EFrnL6xGq7csvkmXA9lcAHY=;
        b=r8nOCYOEizA0HY/HbpZmPUIymlcX3xStlchKBWm5Wa1qQ78DOFb63iY8QKE44UZnXH
         3lARbjJ2wLf8j8AjeMWcvOiAYjksL2dmoLnxR+dIZDheBupVTKwBdIPgE6wURJVIJQiJ
         80emzttnWVqcMJMp2v3I//rmqa1A6i+Bwd1JZoUJyfXfPHIIUU9VCmPov4sR039Ahrb+
         hTSTV13Umk/TIYiBGqH2OLQMrnHer+D16IRHq4Xd9WosmrENhJkZ2Uvhr4sAZiO3nWZ7
         yhbGGT+JnfMLV2SsJZ/Yn+OCyFUUdl3rpg0ALvMUPtoH1JV3pwOEjhG7OB1hyG1C8bNE
         aajw==
X-Forwarded-Encrypted: i=1; AJvYcCUcMRW8itNY8zGz5ZZL3HUqitURwE49CsC5EUNi9lqwqstoCr5vAvWePm3taD3xrVqvSCjYUbgfHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4hGpHXt2R+WYJkO7S9YNmfhkQCFKy5tMJ1TwL4oTQVH9sTwN
	QdnJKXU6YPtHIrJmJ0sT8lcaZvh/HP5KFbbxEz0zdmPIk6ir6k1432bQyWh3onZwUQ==
X-Gm-Gg: AY/fxX5TsbvdfgkVgnoRhaObI53T4Z2sz6J8LA7ASe0EO6RWF0nsC8TMIS16CgZzNUX
	18g/GF1O90cQRYvFBX6156ceLYrKI3fH2PnRCF7yCKY2RvKwcSGzFI93vL2GgG1K3duGj4noFWl
	4f7LRl8bxkxLMsuf2FmWjXhHW5tspO9fZRdhD1W6577TuwTafrwPrdQ1RGf21QBQbV+od3KO4E2
	Bt7CdQ47x8RSIbyneEFQVXBZWARDLTmlxDVL0yw1sXkb2uY+I2vrvoaleyEL+uVM93ODakDRDb5
	bUBNaKTbNpXYWkcam36vT30rcjXP0/pFqAsoGoFONf7f/RRB66nRkbnXYKAnMjQhDoTJKkYilXW
	J/iS/im1fUVXKKEBA7jHic6vXqTnmPYQu2hz3Xe4OwepKC3/2idfDg38sbYdZxLmMMadOXz/8uV
	dqPBuA/JncI9riZnp18n+0vfbA2QzCEoM6Rg2otJOEeutoH9WqKX8=
X-Received: by 2002:a05:6a00:4209:b0:81f:37b2:5657 with SMTP id d2e1a72fcca58-81f81ca9e58mr1139786b3a.17.1768366181800;
        Tue, 13 Jan 2026 20:49:41 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:8065:d8f9:6e13:25a5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81db6e09161sm14267226b3a.24.2026.01.13.20.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 20:49:41 -0800 (PST)
Date: Wed, 14 Jan 2026 13:49:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Tomasz Figa <tfiga@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, Christian Loehle <christian.loehle@arm.com>, 
	Doug Smythies <dsmythies@telus.net>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
Message-ID: <ndqg2mysdc4bsvokmrqubx6rw3oj3lrflxw3naqiohbg7yablf@ccm3rl36dnai>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
 <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
 <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <e1572bc2-08e7-4669-a943-005da4d59775@oracle.com>
 <CAJZ5v0ja21yONr-F8sfzzV-E4CQ=0NqLPmOeaSiepjS4mKEhog@mail.gmail.com>
 <CAJZ5v0hgFeeXw6UM67Ty9w9HHQYTydFxqEr-j+wHz4B7w-aB1Q@mail.gmail.com>
 <rsqh4kpcyodnmcxcdd3yvysdmnfj34fgjtr4pmfhlg2cqtvlhh@iakffruxcnac>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rsqh4kpcyodnmcxcdd3yvysdmnfj34fgjtr4pmfhlg2cqtvlhh@iakffruxcnac>

Cc-ing Tomasz

On (26/01/14 13:28), Sergey Senozhatsky wrote:
> Hi,
> 
> On (26/01/13 15:18), Rafael J. Wysocki wrote:
> [..]
> > > > Bumping this as I discovered this issue on 6.12 stable branch also. The
> > > > reapplication seems inevitable. I shall get back to you with these
> > > > details also.
> > >
> > > Yes, please, because I have another reason to restore the reverted commit.
> > 
> > Sergey, did you see a performance regression from 85975daeaa4d
> > ("cpuidle: menu: Avoid discarding useful information") on any
> > platforms other than the Jasper Lake it was reported for?
> 
> Let me try to dig it up.  I think I saw regressions on a number of
> devices:
> 
> ---
> cpu family      : 6
> model           : 122
> model name      : Intel(R) Pentium(R) Silver N5000 CPU @ 1.10GHz
> ---
> cpu family      : 6
> model           : 122
> model name      : Intel(R) Celeron(R) N4100 CPU @ 1.10GHz
> ---
> cpu family      : 6
> model           : 156
> model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
> ---
> cpu family      : 6
> model           : 156
> model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
> ---
> cpu family      : 6
> model           : 156
> model name      : Intel(R) Pentium(R) Silver N6000 @ 1.10GHz
> 
> 
> I guess family 6/model 122 is not Jasper Lake?
> 
> I also saw some where the patch in question seemed to improve the
> metrics, but regressions are more important, so the revert simply
> put all of the boards back to the previous state.

