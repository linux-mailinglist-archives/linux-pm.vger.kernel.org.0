Return-Path: <linux-pm+bounces-32917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 970ECB321A0
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 19:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DB57B8387
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E053128CC;
	Fri, 22 Aug 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma9zEUp3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1265610B;
	Fri, 22 Aug 2025 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884570; cv=none; b=k8R5DBZkjYumb+Esk/Jl9oukYh/dx4s8fpLZJ9SNnkXndklrxQ+Slx5GiaS253cngYykb0UXvjNGIcbJcBrGj3FBpCKGOcxVTLZnySdykOPmyo5l5tvfh2zCS9dgnIzrosJgGZf3DQR/9Z3cZr1nBv9nRB2QC97EExm2QO0hzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884570; c=relaxed/simple;
	bh=6e/hLhNrAAVCq8R56k5WmJgRfZ8WLuqlSuEHvyTjeJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HogwW4VtVqx21iUg109hYHWfRyOB4yCmS4OahJhiDGZEXZAC/T35scPS9XK4NwgiTQeQFW3NNoitiZxI3KoU2Ntq/mtJMzOP6rrVUoOJ01xR6i6PQwv5dcs3svu/4cYu8gKBpWJBVDMuV0KA2YYpqveKIjTvv9esnwm78P4A8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma9zEUp3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326e71c31so1900241a91.3;
        Fri, 22 Aug 2025 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755884568; x=1756489368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCaKntriNX9X76AtgWLOepHoJZS+qCu003aK7xkrmig=;
        b=Ma9zEUp3hIRX67gFG8P4tRMtTynA77xy6EjqwKDNugNiQKXwysfu4YjlKgP2t4uTOC
         rVRgMKa4/AzdE+vtk1NoTZ96KL73AKvwHZRhr3nVjHKQkAOYU9dBlsMKaWzNxr7Spw2j
         veyyXWPB+kzeRa34nTyB++geYiaGMBDK8NDjmfZQP6Tk9WmynuaLaYbpGBixM9crlL64
         pEcH1awc7FMXibDQQULUTGaAa2XAZroE8xYfmMWH3R/w7ACLRAEYNbtALwg+PR9zV8X+
         o0CljgW/tSPMpIkM0bBRHOcFjL9RDlVbxujpb3E60B+lodlcA1FaZR2rqmP0RNB2bU+/
         feyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755884568; x=1756489368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCaKntriNX9X76AtgWLOepHoJZS+qCu003aK7xkrmig=;
        b=PimRMXSqhq/i+a+ZNmBV+Ath1VDyTecjd1EJPdpqKdAXsaO8hOTZxBfbEqcxyEd50T
         ic1RzD1Msy1fqzcOO13rUytzNrhMX0cCEtre5yxuQaeRS0Kc5RKdsPIY100NnFa1lKCn
         iYm/V7QJqYspIPLmFPKv76jKjTh2rn5rjvfBJ4yjose6dBLAlCnibPph48lI9w2NOxaT
         3TW/rm/8MX7dA2eep9OoE3bymRWXVqdnijBC6jdSfVFsGkJZXG9KjGKlBVjXpTDwtmKc
         iyd/VMATj2dgsqpnphrHSEV/6ZK12zl4PdFT8bOMyfsWpJiJsT+6sJCCN1lRCWsaJpMG
         nhcg==
X-Forwarded-Encrypted: i=1; AJvYcCUOtHya9Z5Qg9nxjNoO5jqw0AkoyZmgzn9DY37L/LLcZ+7Y2XFI6144AYlV2PGom/7zELT7EYQ+BcoJ@vger.kernel.org, AJvYcCW0glxi7eKL2D4z/LrCT/16pV29ciNv9zp09g+6mRwwVgebQA7GRE23R7FTKZ7B8lGGMXVr/oh1F3o=@vger.kernel.org, AJvYcCXLSRbERwA+rdn9h1+Tt6twk1VtQG1z8Q3Yx58K6lQwNozun+m7DGrcue8lWLZ3bAPy85mYwfdcu9XmY3fl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5W548MUr1yFjz1oUk9py39t4+2eCU+yYcFH6YQO3pmYTwaq3d
	WGwVmk4SM0ugs1gGnU5AQZgqi3++8xWfkvMizKzcva+du/3zcFu3uiuO
X-Gm-Gg: ASbGnct2lKwrAbx5ydN/avumPrs3vyB5hzRIYHlMIXlQtHaA+74UPbWT8+NiB49Mo6X
	c/qoR9A5XIoVFCgOjTX34gxnRPb37U/cTfkRpHA7BbQs7mvIcCefDhwkzI2dF1Qkdo8Gis7B03/
	Y028ClExypVEPcORDaDwT00OtnPU0IJ1pfyoMVlKqZkZpVUnJTfXQH8zL/WP+8ldd7EEyYfK2zK
	gfddPfvqsO8nAa0bgZ0SL/8MvWbYIQoob4ft/UdEC8AU845iMQKi9+lNXb9xUJNlsJRwTC/55qi
	Bdu4NCNE8lztl5tPlu/TVYh8wTyC7EmgEWDKwjwPB7uYbVAGwVIJDYc56DSG9tRSSxiYxxrGLKy
	vqlrFRI99Kra/UupIQWhxPbi3aBfuvPxZUgZYs4Il
X-Google-Smtp-Source: AGHT+IEalTXMRLBExjkJfhmWbKfZGlEYQ2B/07dHyNwP07FTl5MUSsyyOzKrKUj/4k/aKk0GC0EYCg==
X-Received: by 2002:a17:90b:4a47:b0:323:264f:bc42 with SMTP id 98e67ed59e1d1-32515ec2d23mr4934158a91.3.1755884568015;
        Fri, 22 Aug 2025 10:42:48 -0700 (PDT)
Received: from x1 (97-120-254-139.ptld.qwest.net. [97.120.254.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254ae8ae9csm287059a91.11.2025.08.22.10.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:42:46 -0700 (PDT)
Date: Fri, 22 Aug 2025 10:42:44 -0700
From: Drew Fustini <pdp7pdp7@gmail.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Matt Coster <Matt.Coster@imgtec.com>, Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <Frank.Binns@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Drew Fustini <fustini@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v13 1/4] drm/imagination: Use pwrseq for TH1520 GPU power
 management
Message-ID: <aKisFGwxmgV7u3XF@x1>
References: <20250822-apr_14_for_sending-v13-0-af656f7cc6c3@samsung.com>
 <CGME20250821222020eucas1p20e40b85b991da0b4d867df76e55350ed@eucas1p2.samsung.com>
 <20250822-apr_14_for_sending-v13-1-af656f7cc6c3@samsung.com>
 <aa8d4ffb-4607-4bff-9d87-8635cd37d439@imgtec.com>
 <55e606c5-9ac0-4e0b-8506-5f88a6fc540e@samsung.com>
 <daf94e44-7c37-4fa6-a31e-b043b7bf46f1@samsung.com>
 <6df6dc78-d86e-4289-bbe2-0bfe4b168c43@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6df6dc78-d86e-4289-bbe2-0bfe4b168c43@samsung.com>

On Fri, Aug 22, 2025 at 01:49:38PM +0200, Michal Wilczynski wrote:
> 
> 
> On 8/22/25 12:26, Michal Wilczynski wrote:
> > 
> > 
> > On 8/22/25 12:04, Michal Wilczynski wrote:
> >>
> >>
> >> On 8/22/25 11:28, Matt Coster wrote:
> >>> On 21/08/2025 23:20, Michal Wilczynski wrote:
> >>>> Update the Imagination PVR DRM driver to leverage the pwrseq framework
> >>>> for managing the complex power sequence of the GPU on the T-HEAD TH1520
> >>>> SoC.
> >>>>
> >>>> To cleanly separate platform-specific logic from the generic driver,
> >>>> this patch introduces an `init` callback to the `pwr_power_sequence_ops`
> >>>> struct. This allows for different power management strategies to be
> >>>> selected at probe time based on the device's compatible string.
> >>>>
> >>>> A `pvr_device_data` struct, associated with each compatible in the
> >>>> of_device_id table, points to the appropriate ops table (manual or
> >>>> pwrseq).
> >>>>
> >>>> At probe time, the driver now calls the `->init()` op. For pwrseq-based
> >>>> platforms, this callback calls `devm_pwrseq_get("gpu-power")`, deferring
> >>>> probe if the sequencer is not yet available. For other platforms, it
> >>>> falls back to the existing manual clock and reset handling. The runtime
> >>>> PM callbacks continue to call the appropriate functions via the ops
> >>>> table.
> >>>>
> >>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> >>>
> >>> Reviewed-by: Matt Coster <matt.coster@imgtec.com>
> >>>
> >>> Would you like me to take the non-DTS changes via drm-misc-next?
> >>
> >> Yeah I think this would be appropriate.
> >> Thanks !
> > 
> > Hi Drew,
> > 
> > Matt offered to take the non-DTS patches (1/4 and 4/4) from this series
> > through the DRM tree.
> > 
> > This leaves the DT binding and TH1520 DT patches (2/4 and 3/4). Would
> > you be able to pick them up through your tree ?
> 
> Aw,
> Sorry I think Matt also meant to take the dt-binding patch, so there would be
> only patch 3 for your tree.

Yes, that makes sense, I will the dts patch through thead-dt-for-next:

[PATCH v13 3/4] riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node

Thanks,
Drew

