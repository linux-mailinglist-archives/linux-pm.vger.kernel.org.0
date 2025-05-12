Return-Path: <linux-pm+bounces-27046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CFDAB3A2F
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 16:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831F619E040E
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 14:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55ED1E3769;
	Mon, 12 May 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD8xiKaC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C7E1798F;
	Mon, 12 May 2025 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059225; cv=none; b=B1AoLtao9U4Y5WW0Y42tnXbwWZR9V94O3aKRxHhoSra5q+g5Aioy2VNWepIVIuyfaksN3rmdbwJ7uY3Q1loU80DqBqn+ZPThYymnj3Nr0rQqFNVjGBzkTWTRmgpxFunLvldfS3cRAgAWAszndO3HnZfKH6pYG7f1QCaVi4oi5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059225; c=relaxed/simple;
	bh=2OJlnvMBtd1Qdxb8D4i8PT0Scjad8idgDm1fH/AmWto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwzRkTqOZXWq+2WiMsFdRuQUahKAaTrgO86sZWhlBkqktlkEgYR67qtKnYS9cpT/jG3TGtX4eII9WNGPR8A/qu2RQVDamfFbUOh1hO9J3lv4RDgpfnXP+WuMiplPM1ye0tU30hoPvZpNuJO/MOpQ/W7jKdOCtN5xQfly4BaoB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD8xiKaC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30aa79ee726so4394291a91.2;
        Mon, 12 May 2025 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747059223; x=1747664023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OJlnvMBtd1Qdxb8D4i8PT0Scjad8idgDm1fH/AmWto=;
        b=jD8xiKaCtzYNVKStiTMMB21PZ3ia82nxzZ+eukoX2JQztyPgDHMOrL5OFz1YTN4Hj6
         v6nH7OMUtuim3cbCrMXtoVREe4GTHrxDZkXPuALfbqidnll+eESOwJ0/x64AZ4AgBkIm
         Z/a06bTYVvp+4H3qmo5w8sVzuFL4rwH0nDyERChno/CResh1Xts5XT9M8quF47a9Wh2B
         aY7yOYT65ThQyywBEf8oz4SM2d3aOx7luMcL2Wo8dIl9ztp881PS3lD+GRFuup8vzqCZ
         nyRM1PbjKkh26G3e0vcbYmUs0jCLnJ4+qBuI29OIUir7RJT4mtIEusDmS7FL1SOn+zDu
         xVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747059223; x=1747664023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OJlnvMBtd1Qdxb8D4i8PT0Scjad8idgDm1fH/AmWto=;
        b=GeqyHrVo18cJcowL0XoGgDyUtmOv+qSN687P6yxvGQByluEfWOr3FucPA5+Yrrn2E2
         rVYGlXl4OGm8V5ebPewHxCg25qFJ3as4QPPKH3vgmxASHRWyj59DSMuI18NRtPv+U0dN
         8lCfhoURsoe+s3OVcmQT5Iw1ODsLSq+A+84Ln56fjhwimfEoac6hlcayRs1orG6heDwi
         hnG1XuY4EfWy3z4ABtzrkLQulsh1DhDsQKVDC4a5ATGqwpWRDQbYQ5to2tUwJ5pkX0i1
         o+IBjJwEKsqAi0FbCUbYACLnhza55+xn2nHTHLOordhbAoGOLm1f0HvtOFQt2WNnoP1y
         QOhg==
X-Forwarded-Encrypted: i=1; AJvYcCVaU23b7tvA3pvp1zDq1U7BXFTpa1kR0raw+mLwbAAK4otxS10eI1NDni+hmRcqVBmemQ/nRoX8mo0=@vger.kernel.org, AJvYcCWUI+7bOEbcNBZEFgCIND0lGqDl/Qeolaw8WespBC+PMydY5yfvfWmnJdkRCEe+IZbdf0DUf/iFyI2JLsfEk17Agw==@vger.kernel.org, AJvYcCXklkrkIhdJtgx3gvPQhljmUlUWhVeFfwVCYksWJFuLB5BOOZLvSxG680kzlb22JB4XR7ADr+l2ZiUiHQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnJHaULg1pF4p/l9+IAZR7kOrbAMx96libz7ogTaxK5LjuZKU
	LQT9wfSFx+mb/R/HhZkJvRbYtGOb6JYCIZUphxCUR0yF+34fNZr2
X-Gm-Gg: ASbGncsY2GwtHDWgQpEUckJ7ouIlsJ2PQJ7iH35x+fd+6rhSCwxGVBPrVE5/vbK/SDX
	/IQzSdsBlklcrjFOglW+ZMoEllaKj9EZY1N1e5Fn34xH+nVaAL+4ki5tR6BlVBNvwBBQrv0wPml
	qkKkODINZ9VhkX9aQk/07EHCelnIUTx1/YghEeHXT28KDmplgBTZhRNOYUS1Yn/hoJIFIcupgaa
	g1CsML0kdcpGPF10rIEMGkg7o84icHBgU+Sa+vxYQhmkPbGOw3bdXQ17Vc2SetRFPMhqroqZZUE
	RpThzCD/nbRG26cIj8NhJWT8upXR1Kswp4RZIuVomEmvNWN1bw==
X-Google-Smtp-Source: AGHT+IH5gUoco7N8sKGHqASp+t6n1KYZvtsdLBTVel5nTdgyJkB/lYXE+HXry+XviOclf5k9LSJ5pA==
X-Received: by 2002:a17:90b:3e4e:b0:2ee:c2b5:97a0 with SMTP id 98e67ed59e1d1-30c3d62e4c5mr22364395a91.25.1747059223077;
        Mon, 12 May 2025 07:13:43 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39df09dbsm6650922a91.26.2025.05.12.07.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:13:42 -0700 (PDT)
Date: Mon, 12 May 2025 11:13:36 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
Message-ID: <20250512141336.b72ga37qtlrvgaut@hiago-nb>
References: <20250507160056.11876-1-hiagofranco@gmail.com>
 <20250507160056.11876-4-hiagofranco@gmail.com>
 <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
 <20250508202826.33bke6atcvqdkfa4@hiago-nb>
 <CAPDyKFr3yF=yYZ=Xo5FicvSbDPOTx7+fMwc8dMCLYKPBMEtCKA@mail.gmail.com>
 <20250509191308.6i3ydftzork3sv5c@hiago-nb>
 <20250512045613.GB31197@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512045613.GB31197@nxa18884-linux>

Hi Peng,

On Mon, May 12, 2025 at 12:56:13PM +0800, Peng Fan wrote:
>
> Ulf's new API dev_pm_genpd_is_on needs to run after power domain attached.
>
> But if run after power domain attached, there is no API to know whether
> M4 is kicked by bootloader or now.
>
> Even imx_rproc_attach_pd has a check for single power domain, but I just
> give a look again on current i.MX8QM/QX, all are using two power domain
> entries.
>
> >
> >>
> >> In this way we don't need to export unnecessary firmware functions
> >> from firmware/imx/misc.c, as patch1/3 does.
>
>
> I think still need to export firmware API. My idea is
> 1. introduce a new firmware API and put under firmware/imx/power.c
> 2. Use this new firmware API in imx_rproc.c
> 3. Replace scu-pd.c to use this new firmware API.
>
> Or
> 1. Export the API in scu-pd.c
> 2. Use the API in imx_rproc.c
>
> With approach two, you need to handle them in three trees in one patchset:
> imx/pd/rproc.
>
> With approach one, you need to handle two trees in one patchset: imx/rproc tree,
> then after done, pd tree

This patch series is already implementing approach one, as I understand,
right?

The difference is I moved this API from drivers/pmdomain/imx/scu-pd.c to
firmware/imx/misc.c, and exported it there. But you think I should
create this new file firmware/imx/power.c and move the API from scu-pd.c
to power.c, is my understanding correct?

>
> Regards,
> Peng

Best Regards,
Hiago.

