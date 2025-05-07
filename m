Return-Path: <linux-pm+bounces-26824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEB3AAE58B
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 17:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC8170800
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E441E28B7E2;
	Wed,  7 May 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml4cKsdE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7362A28B7E0;
	Wed,  7 May 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633153; cv=none; b=QamYurzR9RhYPdN4DoBzSbdozZVU+4ma9iBccaxvkBjhHMN54NkGBMlf1f3bVUj5IUnFWZKI+4wzbfp7R/CPBEIpDXWN2SpSQnCNHgUeHQR8i7TQXklDdchbkVyISixdaxTrCs8wLsvZeQ+W0v+LvrRqCRW/A5vo77UXedw6GDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633153; c=relaxed/simple;
	bh=sCmXTEs9MesTHuPpFJ/NvOgzXDUn8ZZ+zdOFzC8r5lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGyy5eXwijAq/NaB2LNbOChHaU5ZNwFWKLEc4xxLZLnGNBkLnOoGqzfnusRwA0aD8v7jSTCNpFH+Zvb8oOum7LQ9YyvEoPnwhBMNGzIc4VRmPulC47RxNJxRncXOYW9EeiEh+zfe8m+yElyxo1PVXlfn9qCvH4myTopV9WsnpRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml4cKsdE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22e7eff58a0so319995ad.3;
        Wed, 07 May 2025 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746633151; x=1747237951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCmXTEs9MesTHuPpFJ/NvOgzXDUn8ZZ+zdOFzC8r5lA=;
        b=ml4cKsdEHJVaXESB7AuKMXmkK8VWMEtdmWvFdedzaRACbqXnV2uXUhVvdZFXDYceX1
         Win6vssg9nWTdoi2NrWb3TCe7fChEsBfiWXa/Io8MKBHQTFpJOMTbIhL8iYWu1PgeAoc
         wBMpMPbhsaZsI9UHoR04DTbWCpc2sZTYrjpYqnYuukaFtWMWxBRLbqlydce/IVX59PUj
         oAFdkq5aM08pAtJFg0wdTkQMMBsthK/q3kBWA8fE0+1NMl+r9ObDijV1WWxpmx5tV66B
         w3SZpomXBx4M9KdIJXEn/1VnWTCIqu7SoZEfsoxCgvZ7M1KvVnZJCp07mUlDB8mhWCxk
         z3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746633151; x=1747237951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCmXTEs9MesTHuPpFJ/NvOgzXDUn8ZZ+zdOFzC8r5lA=;
        b=Du9gf8ZHW7TxS8wfv9M6XIm3pPdVk9BgW4PXXS6DnoyrBJga6rQwWPMod2e6GCzgIA
         W6w/tDnyDL51JAZeH2WgtP9MENSgm+Z5P60qZaKy4eo+yOV+gjs2t8T2RevEvr7YuIn6
         t3aKTL8rxoGhwK1OLK3UB2kNGSwqGUSl2NomM40aDsg4Aue4zplVkEgApsJNhAZ6Yrx1
         P2wx/lygYA1jxZRKzaUgFheC/7yBvSlS8cA2eo2Zt5EnMdYqY1Lg43yjFZmrV9GxP6w9
         9DPQa9IR5cGbaymLrhSoELBUiXizJ5GCQfo7qUwJzG2WnsKlEWKGvIRNkCc2hfh4GmL1
         Fh1g==
X-Forwarded-Encrypted: i=1; AJvYcCUrcDvnZq/JPIfvV1kiF7Fe0YC1u/RyCTjjfrTWVXMarOdmfgQByWW/qS6b4hMSGjScFmyMdBiqJQU=@vger.kernel.org, AJvYcCWXqz+9lm6/9vocqsWYsJgnnHv2vEindeCDG0ajjjV9EgMYCuhnMt2F6RUhIoH1bcx1W1ugzzEokuUA17o=@vger.kernel.org, AJvYcCWrHUQnrxjfIemVLfMmKLETQgKzFUV7zSfh4Xi+XYgMO/ygY01rKmSIFChSnnxMIJevzww+vGSauTDZLkFvUJRS+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUDyykNk8u/k5uFmoE2kEXGXhN4M1UwY15IJJNWI/lCDBtASQ
	bQpzN3n3Sl7Xyw9eOX8n2m6ZA1hfnmDg81TnTTAJNOvsEXNYwLyO
X-Gm-Gg: ASbGncvEaQozJr+TZ1P95ISJvg0hjZykgtxBp76/pgf21hBYDcoRCgBjWbG7TQzkrT2
	SJz5Eq0HCFLi1oSnUbfvs342UoJ6eiNywIAqEPsAgri8vTc4SVedUBi79ofZukWYtgUN00yoopP
	qw8G3rZrdxUvpJxFOWhGxCvLvqJqUKaT+4xKB0BCIunHmudwUpHFEUyavN2bbn6s9gYql4TZ2n5
	r7FZ/QQpdWQhMTc9MhmqG7CWsoq3p+Cl8Vox6d9nJSoCBDe3PTqRm5BrLTt3msRGYNT61fLfyW4
	GKXDERfhzaZiJZxbtu/DocE4DQe2pJOReNTMIfQ=
X-Google-Smtp-Source: AGHT+IGIeRiD//5aB3Lp0GTAmkUq9HKBWgvRug2zQlreh3HMZNf0lXvR6y+wTe0PX9iANCSO8Ya92Q==
X-Received: by 2002:a17:902:d2d0:b0:224:2175:b0cd with SMTP id d9443c01a7336-22e5ecade46mr51329175ad.26.1746633150657;
        Wed, 07 May 2025 08:52:30 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228f62sm95204515ad.168.2025.05.07.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 08:52:29 -0700 (PDT)
Date: Wed, 7 May 2025 12:52:24 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 2/3] firmware: imx: move get power mode function from
 scu-pd.c to misc.c
Message-ID: <20250507155224.uoxabve2qxncioqh@hiago-nb>
References: <20250505154849.64889-1-hiagofranco@gmail.com>
 <20250505154849.64889-3-hiagofranco@gmail.com>
 <20250506044618.GC24259@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506044618.GC24259@nxa18884-linux>

Hi Peng,

On Tue, May 06, 2025 at 12:46:18PM +0800, Peng Fan wrote:
> On Mon, May 05, 2025 at 12:48:48PM -0300, Hiago De Franco wrote:
> >From: Hiago De Franco <hiago.franco@toradex.com>
> >
> >Move imx_sc_get_pd_power() from pmdomain/imx/scu-pd.c to
> >firmware/imx/misc.c and rename it to imx_sc_pm_get_resource_power_mode()
> >to maintain the same naming logic with other functions in misc.c.
> >
> >This makes the API available for other use cases. For example,
> >remoteproc/imx_rproc.c can now use this function to check the power mode
> >of the remote core.
>
> Better put this patch at the first I think.

Ok, I will do that.

>
> To be simple, I think just export
> imx_sc_get_pd_power in drivers/pmdomain/imx/scu-pd.c.
> And add the function declaration in include/linux/firmware/imx/sci.h.

I do not think this is correct, since it is specific to the scu-pd.c
driver and none of the functions there are exported. I believe the
correct implementation is moving to misc.c and export it there, just
like the other SCU API functions.

I will send a v2 today with the comments adressed, thanks.

>
> Not sure Ulf or Shawn is good with it.
>
> Regards,
> Peng
>

Cheers,
Hiago.

