Return-Path: <linux-pm+bounces-863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BE980B669
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 21:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3361C208C2
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 20:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E881C692;
	Sat,  9 Dec 2023 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JIjzUlIx"
X-Original-To: linux-pm@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26660E5;
	Sat,  9 Dec 2023 12:59:20 -0800 (PST)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: festevam@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 46A1486F67;
	Sat,  9 Dec 2023 21:59:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702155557;
	bh=gQ/HXQgkXMpnniubARRaHA56r7dEGMzZvC/+/oSsEdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JIjzUlIxn58PPddHyK10SL1dva2rQt5QldFDJ7R5VDFU1KPDKs4t5WLEBB+VQt4PI
	 fCDBPSpXxyWzeNvdP6u7aiv1lJTd++rY07/xr5Ckv+quxAf6/D19L1WJbCiPbZWBCr
	 GWHL//WmdIPbYBgMvcIrQApQ3nwW5WLkc8+dvMlX/u664nF9v354DvqeXmKxbvh006
	 /QrOed1zGE7oopa7QWjqaodXJ+5bqR7k9ZbHP11Qo3ApLMg5BT/kFZbh3rus/zylc1
	 3uDpze8R3puGTg72pxdnQurZRMZs17kHF/uJAAiIKOa/C11kJyo6zNI5Vo56Gh66J2
	 bvDBFtzUZps/Q==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Dec 2023 17:59:17 -0300
From: Fabio Estevam <festevam@denx.de>
To: Conor Dooley <conor@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, daniel.lezcano@linaro.org,
 rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 conor+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range min/maxItems
In-Reply-To: <20231209-singular-tighten-eef5f7909dcd@spud>
References: <20230928222130.580487-1-festevam@gmail.com>
 <20231002-unheard-copy-f9dceb6498a9@spud>
 <CAOMZO5Di6Saq_r2k8AkGeANRvXwwx26U=Vf5-Eu-_2Qhu5sDCw@mail.gmail.com>
 <20231209-singular-tighten-eef5f7909dcd@spud>
Message-ID: <a591318fbba10b764075e9395ddd9f7f@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Conor,

On 09/12/2023 17:23, Conor Dooley wrote:

> You're adding the constraints and items at the wrong level AFAICT.
> I think something like the below better matches your constraints?

Thanks for your example.

With your change the fsl,imx93-tmu case works correctly:
if I pass the number of fsl,tmu-range entries different than 7,
dt_binding_check correctly complains.

However, if I pass 7 entries to fsl,qoriq-tmu it should complain as it 
expects 4, but it
does not.

On top of your patch:

--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -104,7 +104,7 @@ additionalProperties: false
  examples:
    - |
      tmu@f0000 {
-        compatible = "fsl,imx93-tmu";
+        compatible = "fsl,qoriq-tmu";
          reg = <0xf0000 0x1000>;
          interrupts = <18 2 0 0>;
          fsl,tmu-range = <0x000a0000 0x00090026 0x0008004a 0x0001006a 0 
0 0>;

make dt_binding_check DT_SCHEMA_FILES=qoriq-thermal.yaml
   LINT    Documentation/devicetree/bindings
   DTEX    
Documentation/devicetree/bindings/thermal/qoriq-thermal.example.dts
   CHKDT   Documentation/devicetree/bindings/processed-schema.json
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   DTC_CHK 
Documentation/devicetree/bindings/thermal/qoriq-thermal.example.dtb

Any suggestions?

Thanks

