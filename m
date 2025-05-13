Return-Path: <linux-pm+bounces-27108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44C4AB5E3A
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 23:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695C0467620
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 21:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AEC1FAC4B;
	Tue, 13 May 2025 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiZz66/H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420EB53365;
	Tue, 13 May 2025 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170351; cv=none; b=tNucaaRKXGPL1GpVwHcSUwSikFAIVsWz3STj2r8qnyTu3MFpqrtTKQRBreCVb8rJr+JrlAJK7XY19u9u9KFjo25imVvIYiAos7/LpiFHgsyAbM9bjcfl7plITZeVr+RHhJpnBYlN+ciiFxVegykM+o45ikG7Pypmo0frmqxNqdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170351; c=relaxed/simple;
	bh=jprtOsgVW2F9aVvUz6IyNAsOxzDylpa9XA6Aj2LsBB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTkSv4wLsix10uDn8g5JfTwQFylLw2/dcNT1o3EvwI5ANpVpJ84swyXDq5SotfG/vTurB4b3FtjJxGBZZgVldyK+Ji5P9m+9y4UKf6ZzLkG+bx38Dq7XRO6Mh4rb4IdVBk0Uyiz3XPgpBMCECARTyggxw0RB/ivgSopRJj9OfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiZz66/H; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-878af63c5b3so3483921241.1;
        Tue, 13 May 2025 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747170348; x=1747775148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PF/f05Jnn8cBIgm4MkrIADKbDArlZkrF9k16SO3CXK4=;
        b=UiZz66/HayMPBLdb1QThQIqpxvb7b+smLrKGajK6ghL1TvMiI1F605LQq4H657iex/
         oM/hS9WqoPMW1iWmGGkIQX0zhFfWG1CjnxBzoqxtUrqxbkY8YqTIv7ISLP9yPUD8N/rd
         beJLV6O2lu7siGKbpf8vVAhKkVTFYbhbeQ3PUkc0PwKT+8kThQqEThy0Dwx3FhmFeQ0f
         GKyRo04lt7gLdSZVtpA6ZsOBs7WX0XxoAGQazoJlZsdzQ8gK8Al7gaMG4BmLpOsV7uL8
         u6x2BzQb0B0koA18ktGz7cIIUa/4qnL4UDMhaGubiiLk4EySnkYUZ8KABWGNiUgxoKph
         2Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747170348; x=1747775148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF/f05Jnn8cBIgm4MkrIADKbDArlZkrF9k16SO3CXK4=;
        b=AsOoCSAJE1B5RFKfjN+LE9JeZgFBHfxl6UUHXRyMbfQXEcWT15q2oX+oJuxmFYgNav
         cFrKoqXoOmlDf9IAK1V6jBMArgFebOfUWu3ly7QHGRrPPTesSZKaSEEGA5BZykC5gXV6
         3IoaQBrbp6FunNrDEg2enwcELW01/0gdZ0a2yN9xps+0oeY8Uns8JyfhZrG3lrjN2mlq
         POF4QBDQTrfqQt68TgS1CZomYADANJhBnVqpGhtvk7XVPm+TS1x6+UMiBr7U47MnswED
         Lxj3j91gBNx5Dz4Lo0L3GDmbv8RtDxk1ShIC1DFW+kvWURZXx8BVU6uWwyRRoIjCJte0
         P/mA==
X-Forwarded-Encrypted: i=1; AJvYcCUUWoqMn8JNFqfnTa3ytphtcvZuXeaRbW2aI5ld4t12X68MzMowKDx+y58Eqh3LSjVzFWtUDqA140ooDyDQvlNvTA==@vger.kernel.org, AJvYcCVsOjKrQOKtNG0CarbhFK4WXdoOEiFA0aXGii3pazoISr5lD3lQHPlo2+ChWj/9vblSPE503lpyP5IwFaA=@vger.kernel.org, AJvYcCW/uAJLh6BaVvVxOf/BsMTQ06rRnmSL3ynSn384wTbJg0+8XUDF3/MvWnqevb2NKT8Y47+KDwFjkto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkG42Vpe9xFTjOOqk3JjKUl/rcQ5qjJNPNHtF7pLLgLSjbYZe
	NgUksuwfWErH22i6+xC9uNRTGMRveX+0J/vkqz1G1c6xreMMOvt8
X-Gm-Gg: ASbGnctPssBV1JDrqSQuzfyeDtoYIrSuFDjB9i0VewOSRLJaG/d+CXiFmvK4ZYflbaw
	EvHQ0Fw0qx4pQIYAAtkb56F5wQGh8E7MOO2zh/nfIsvLEcSj9xyX8w8exXlPqn8QvPlI66F/3LO
	R7ef7JSusPsYDo5FSbtJ8oOfv6p+kcuzDBWP2BqbY1IdAJ5IvkumU3BUOxsCYZHVTMzMgmGnx/L
	W3nfSfdwAgDhC1up3PaSJv1hGJrFguSceWUDSkn1bV8J9xQ7yKm5MaeD2Yl4CDhi1auERJ4ZeEd
	Y+Z8uJiXJbc4MGqcc0l0rVJVTFca3tQcpWa9R0rEjDZ4wvpX2g==
X-Google-Smtp-Source: AGHT+IGxvFdQRn97UaiBY7c/whlkImXIkzkXz6uwmHgp7GwxfHPgSbQVCxBX8oQoHlKhKWt+naoXiA==
X-Received: by 2002:a05:6102:948:b0:4c3:6544:c250 with SMTP id ada2fe7eead31-4df7ddf92ecmr1108581137.23.1747170347966;
        Tue, 13 May 2025 14:05:47 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-879f6139e8csm7562202241.2.2025.05.13.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 14:05:47 -0700 (PDT)
Date: Tue, 13 May 2025 18:05:41 -0300
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
Subject: Re: [PATCH v2 1/3] firmware: imx: move get power mode function from
 scu-pd.c to misc.c
Message-ID: <20250513210541.f6ptdxq5ocni3bp3@hiago-nb>
References: <20250507160056.11876-1-hiagofranco@gmail.com>
 <20250507160056.11876-2-hiagofranco@gmail.com>
 <20250513073822.GA14572@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513073822.GA14572@nxa18884-linux>

Hi Peng,

On Tue, May 13, 2025 at 03:43:37PM +0800, Peng Fan wrote:
> Hi Hiago,
> 
> On Wed, May 07, 2025 at 01:00:54PM -0300, Hiago De Franco wrote:
> >From: Hiago De Franco <hiago.franco@toradex.com>
> >
> >Move imx_sc_get_pd_power() from pmdomain/imx/scu-pd.c to
> >firmware/imx/misc.c and rename it to imx_sc_pm_get_resource_power_mode()
> >to maintain the same naming logic with other functions in misc.c.
> >
> >This makes the API available for other use cases. For example,
> >remoteproc/imx_rproc.c can now use this function to check the power mode
> >of the remote core.
> >
> >Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> >---
> >v2: moved this patch to be the first one
> >---
> > drivers/firmware/imx/misc.c           | 47 +++++++++++++++++++++++++++
> > drivers/pmdomain/imx/scu-pd.c         | 29 ++++-------------
> > include/linux/firmware/imx/svc/misc.h |  8 +++++
> > 3 files changed, 62 insertions(+), 22 deletions(-)
> >
> >diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
> >index d073cb3ce699..61fcb0066ec9 100644
> >--- a/drivers/firmware/imx/misc.c
> >+++ b/drivers/firmware/imx/misc.c
> >@@ -37,6 +37,18 @@ struct imx_sc_msg_resp_misc_get_ctrl {
> > 	u32 val;
> > } __packed __aligned(4);
> > 
> >+struct imx_sc_msg_req_get_resource_power_mode {
> >+	struct imx_sc_rpc_msg hdr;
> >+	union {
> >+		struct {
> >+			u16 resource;
> >+		} req;
> >+		struct {
> >+			u8 mode;
> >+		} resp;
> >+	} data;
> >+} __packed __aligned(4);
> >+
> > /*
> >  * This function sets a miscellaneous control value.
> >  *
> >@@ -135,3 +147,38 @@ int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > 	return imx_scu_call_rpc(ipc, &msg, true);
> > }
> > EXPORT_SYMBOL(imx_sc_pm_cpu_start);
> >+
> >+/*
> >+ * This function gets the power mode from a given @resource
> >+ *
> >+ * @param[in]     ipc         IPC handle
> >+ * @param[in]     resource    resource to check the power mode
> >+ *
> >+ * @return Returns < 0 for errors or the following for success:
> >+ * IMX_SC_PM_PW_MODE_OFF  0	Power off
> >+ * IMX_SC_PM_PW_MODE_STBY 1	Power in standby
> >+ * IMX_SC_PM_PW_MODE_LP   2	Power in low-power
> >+ * IMX_SC_PM_PW_MODE_ON   3	Power on
> >+ *
> >+ * These are defined under firmware/imx/svc/pm.h
> >+ */
> >+int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc, u32 resource)
> >+{
> >+	struct imx_sc_msg_req_get_resource_power_mode msg;
> >+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> >+	int ret;
> >+
> >+	hdr->ver = IMX_SC_RPC_VERSION;
> >+	hdr->svc = IMX_SC_RPC_SVC_PM;
> >+	hdr->func = IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE;
> >+	hdr->size = 2;
> >+
> >+	msg.data.req.resource = resource;
> >+
> >+	ret = imx_scu_call_rpc(ipc, &msg, true);
> >+	if (ret)
> >+		return ret;
> >+
> >+	return msg.data.resp.mode;
> >+}
> >+EXPORT_SYMBOL(imx_sc_pm_get_resource_power_mode);
> >diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
> >index 01d465d88f60..945f972e636f 100644
> >--- a/drivers/pmdomain/imx/scu-pd.c
> >+++ b/drivers/pmdomain/imx/scu-pd.c
> >@@ -54,6 +54,7 @@
> > #include <dt-bindings/firmware/imx/rsrc.h>
> > #include <linux/console.h>
> > #include <linux/firmware/imx/sci.h>
> >+#include <linux/firmware/imx/svc/misc.h>
> > #include <linux/firmware/imx/svc/rm.h>
> > #include <linux/io.h>
> > #include <linux/module.h>
> >@@ -328,27 +329,6 @@ static void imx_sc_pd_get_console_rsrc(void)
> > 	imx_con_rsrc = specs.args[0];
> > }
> > 
> >-static int imx_sc_get_pd_power(struct device *dev, u32 rsrc)
> >-{
> >-	struct imx_sc_msg_req_get_resource_power_mode msg;
> >-	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> >-	int ret;
> >-
> >-	hdr->ver = IMX_SC_RPC_VERSION;
> >-	hdr->svc = IMX_SC_RPC_SVC_PM;
> >-	hdr->func = IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE;
> >-	hdr->size = 2;
> >-
> >-	msg.data.req.resource = rsrc;
> >-
> >-	ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
> >-	if (ret)
> >-		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
> >-			rsrc, ret);
> >-
> >-	return msg.data.resp.mode;
> >-}
> >-
> > static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
> > {
> > 	struct imx_sc_msg_req_set_resource_power_mode msg;
> >@@ -438,7 +418,12 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
> > 	if (imx_con_rsrc == sc_pd->rsrc)
> > 		sc_pd->pd.flags = GENPD_FLAG_RPM_ALWAYS_ON;
> > 
> >-	mode = imx_sc_get_pd_power(dev, pd_ranges->rsrc + idx);
> >+	mode = imx_sc_pm_get_resource_power_mode(pm_ipc_handle,
> 
> I mean, not change scu-pd.c in this patchset. After
> imx_sc_pm_get_resource_power_mode landed, you could update scu-pd.c.
> 
> Otherwise you are touch three trees which are a bit hard to manage for
> maintainers:
> scu-pd.c under linux-pm tree
> misc.c under linux-imx tree, I think using power.c should be better.
> imx_rproc.c under linux-remoteproc tree
> 
> My suggestion was that
> patch 1: firmware: imx: Introduce imx_sc_pm_get_resource_power_mode
> patch 2: remoteproc: imx_rproc: Detecting power mode of M4 for i.MX8QX
> Patch 3: pmdomain: scu-pd: migrate to use imx common pm API
> 
> Patch 3 could be separate out in future patchset to avoid handling three trees.

Ok, got it. I will prepare the v3 with your suggestions. Thanks.

> 
> Regards,
> Peng
> >+						 pd_ranges->rsrc + idx);
> >+	if (mode < 0)
> >+		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
> >+			pd_ranges->rsrc + idx, mode);
> >+
> > 	if (mode == IMX_SC_PM_PW_MODE_ON)
> > 		is_off = false;
> > 	else
> >diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware/imx/svc/misc.h
> >index 760db08a67fc..376c800a88d0 100644
> >--- a/include/linux/firmware/imx/svc/misc.h
> >+++ b/include/linux/firmware/imx/svc/misc.h
> >@@ -55,6 +55,8 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
> > 
> > int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > 			bool enable, u64 phys_addr);
> >+
> >+int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc, u32 resource);
> > #else
> > static inline int imx_sc_misc_set_control(struct imx_sc_ipc *ipc,
> > 					  u32 resource, u8 ctrl, u32 val)
> >@@ -73,5 +75,11 @@ static inline int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> > {
> > 	return -ENOTSUPP;
> > }
> >+
> >+static inline int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc,
> >+						    u32 resource)
> >+{
> >+	return -ENOTSUPP;
> >+}
> > #endif
> > #endif /* _SC_MISC_API_H */
> >-- 
> >2.39.5
> >

Best Regards,
Hiago.

