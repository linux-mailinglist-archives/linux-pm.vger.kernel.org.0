Return-Path: <linux-pm+bounces-38653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F87FC86E43
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 20:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CA43A9639
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EFB33AD98;
	Tue, 25 Nov 2025 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3+WFYd7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C122FF144
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100647; cv=none; b=b9+UH/tMUcTadT7fYJ4tOjWAPN8H0YSOJpSS7a7N/zz1oPl2vUFxzYr7sgpDK1K96+ddvpvtCBAk9kmxVOMJSUSvY3exb8TRTtwxLa/jrhBksHEG3/dKa2kQePb/c8ZgeAQ94rMblor/R9fzmbxFU7+kvVaigEd6y4t39UJZ5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100647; c=relaxed/simple;
	bh=iokwoTFVPBOTaPfOIU5c7pX/GalN7fc0nJfgCYlBKvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJuaN2qk8fSqvp5YKZ5K73RMrulDQM5/Vq6dLG3KVl65ry588qhzQtt+9scqqXzOgvJzwNj7wBbb773/cxPqoPxUFO8SnSYpBkeAny/dNvDSxRRiQAXWAenLhPTeWH9xgewN7viuo3whDBLTgwUWDCkR/sb6k0cfyAYgoBekPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E3+WFYd7; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso3691475f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764100643; x=1764705443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1UnNoOWnCZ6jNATqSLrvL0gVBX8cPau2AT5/t6kV9Y=;
        b=E3+WFYd7f5+MIm16F523Jp2L/0FdmLr2llL7NvcjJTaVC7gDZ4jAJ3ZT92cjbATxxy
         K1neAO0iFSJp8rd6CMc46LL0vFY2ZxYuff7IhW47BekmuS9OlG6eozp9ZPoQWIpHT89C
         NFXd3qkiLizg7f/a3lWPgX8VVnaHVdcUt3zGL+uCUE6EbbzGXUYHSpasPSbAXqfSPobO
         e3LLS+2RS+Ol8n/1DBwdv47Vl9IdOsxUE+KJBIv0pUYV78VVC55KiqzuPCPQcRc/6xDg
         F0O6d/mQ47TNSJurO7m1fpqIYpSPMarRaECaISWbkqPu5iLzwy0CSkkxPMjANFl2VqeJ
         lzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764100643; x=1764705443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1UnNoOWnCZ6jNATqSLrvL0gVBX8cPau2AT5/t6kV9Y=;
        b=LdpWRNXLkm/qtpBXqdhBsfa7LH46R3IJbV8r1vbKQyTB5Mb0rCYZUpSx7jZziW8rAP
         NJ3sceG4rtRnNaOwRN5tUafh3jxWbZXZ2SPgVCKg1+51MldHSMurTQ18fPS+3p/9OaBS
         +mlxtuLgWAaHV2cb06YC03PQgHKtstSOc9uhIItlHT0V4sQOjSlu+f3yRYAsrIQ3r7+g
         ywqsyZl3xOYSLQ2g3r3tVnFzjR8SixOqlu5ldTsWecpTMV9vHcHrNnh3AIaCUEZlzQxm
         47YSQwYI3d7FRkMaWMsZsSidJqpuTgzeTa2j7mEuTdG2nShv2qPIbO8f22SX2/CeQjy0
         ra4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIrPC1GdGeiXynPRfFrojHF2LRzQSIHHJwW300Cw4NbkAIvFPxQaMbpunjifAJfQrfzigA0/PreA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm11e/atklAgpxa/UFcU3dYjJLsbZwjzO46QSBZkDbi2ZB9eLm
	rN15YbmHxqKlLhzpGhdi87ZPYaAVo4LfyCQ4FQM26lC8/b34l+3aJwwdkHCAuZlvbjo=
X-Gm-Gg: ASbGncuFh/OOKENvqnFsC9pfq/hpI7fh0ZWn0kdU3aECxqfTcd1fpKSegzTXJ/yllfe
	IX0n5WT00p8LYqdAPz+sZ2keYPn0flS75PzsdS7XMrOQzbmM56crzvjHZvD4z04pnYWT00gL/nb
	rte5r2hZYErNJ1/ql9Gf1zSeKJpvABiwgpjHP01aStsbdNpD2GZ2XzgD7gitif7k/7yxmoJTFYq
	SwKcAO1CQsil0CQTZvrLT9cEDpKvs6dnbPNBVKjfXrhD0g2pL2jP2pzv718tn72ByIM0EKdHiko
	uqvSf+8cOVqecIJTsSy4pWMtD65nQNWK3TIQXFWHqClkQCRQpFa/8P2Wzc9v2j/JHVFiuz0BB8x
	GTEhzoXi1LQB/VWb2TMmqiZ78vogebuqlGby/BUyOw2X4nIRl37ayFk5eDCeaireMHdz/ZmFGhW
	FkG4OHA50Q8q4VXmrodqmK+ZA=
X-Google-Smtp-Source: AGHT+IEAbkYexDq6opE/RHcWGXGaG9IQZqQuowS+lidqh7NE88eFU6gVV4oNIEt+OqoiQG7s1o7+ow==
X-Received: by 2002:a05:6000:2881:b0:42b:3dfb:645c with SMTP id ffacd0b85a97d-42cc1ac9debmr18306375f8f.12.1764100643122;
        Tue, 25 Nov 2025 11:57:23 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff23:4430:a656:9e9b:eea0:17e9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm36157180f8f.33.2025.11.25.11.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 11:57:22 -0800 (PST)
Date: Tue, 25 Nov 2025 20:57:18 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/10] Add support for handling PCIe M.2 Key E
 connectors in devicetree
Message-ID: <aSYKHjpJkXWUVIyo@linaro.org>
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>

On Tue, Nov 25, 2025 at 08:15:04PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> This series is the continuation of the series [1] that added the initial support
> for the PCIe M.2 connectors. This series extends it by adding support for Key E
> connectors. These connectors are used to connect the Wireless Connectivity
> devices such as WiFi, BT, NFC and GNSS devices to the host machine over
> interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support for
> connectors that expose PCIe interface for WiFi and UART interface for BT. Other
> interfaces are left for future improvements.
> 
> Serdev device support for BT
> ============================
> 
> Adding support for the PCIe interface was mostly straightforward and a lot
> similar to the previous Key M connector. But adding UART interface has proved to
> be tricky. This is mostly because of the fact UART is a non-discoverable bus,
> unlike PCIe which is discoverable. So this series relied on the PCI notifier to
> create the serdev device for UART/BT. This means the PCIe interface will be
> brought up first and after the PCIe device enumeration, the serdev device will
> be created by the pwrseq driver. This logic is necessary since the connector
> driver and DT node don't describe the device, but just the connector. So to make
> the connector interface Plug and Play, the connector driver uses the PCIe device
> ID to identify the card and creates the serdev device. This logic could be
> extended in the future to support more M.2 cards. Even if the M.2 card uses SDIO
> interface for connecting WLAN, a SDIO notifier could be added to create the
> serdev device.
> 
> Open questions
> ==============
> 
> Though this series adds the relevant functionality for handling the M.2 Key M
> connectors, there are still a few open questions exists on the design. 
> 
> 1. I've used the M.2 card model name as the serdev device name. This is found
> out by comparing the PCIe VID:PID in the notifier. Is this approach acceptable?
> I did not use the PID as the serdev name since it will vary if the SDIO
> interface is used in the future.
> 
> 2. PCIe client drivers of some M.2 WLAN cards like the Qcom QCA6390, rely on
> the PCIe device DT node to extract properties such as
> 'qcom,calibration-variant', 'firmware-name', etc... For those drivers, should we
> add the PCIe DT node in the Root Port in conjunction with the Port node as
> below?
> 
> pcie@0 {
> 	wifi@0 {
> 		compatible = "pci17cb,1103";
> 		...
> 		qcom,calibration-variant = "LE_X13S";
> 	};
> 
> 	port {
> 		pcie4_port0_ep: endpoint {
> 			remote-endpoint = <&m2_e_pcie_ep>;
> 		};
> 	};
> };
> 
> This will also require marking the PMU supplies optional in the relevant ath
> bindings for M.2 cards.
> 
> 3. Some M.2 cards require specific power up sequence like delays between
> regulator/GPIO and such. For instance, the WCN7850 card supported in this series
> requires 50ms delay between powering up an interface and driving it. I've just
> hardcoded the delay in the driver, but it is a pure hack. Since the pwrseq
> driver doesn't know anything about the device it is dealing with before powering
> it ON, how should it handle the device specific power requirements? Should we
> hardcode the device specific property in the connector node? But then, it will
> no longer become a generic M.2 connector and sort of defeats the purpose of the
> connector binding.
> 
> I hope to address these questions with the help of the relevant subsystem
> maintainers and the community. 
> 
> Testing
> =======
> 
> This series, together with the devicetree changes [2] was tested on the
> Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the WCN7850 WLAN/BT M.2
> card connected over PCIe and UART.
> 
> [2] https://github.com/Mani-Sadhasivam/linux/commit/acbee74a5c90fc8839bb7b6f326c677ee1c0d89c

Thanks for working on describing the M.2 connectors properly in the
device tree!

I haven't had time to look into this in detail yet, but a quick look at
the dt-bindings and examples looks good to me! Thanks for keeping the
bindings as generic as possible.

I have a small nitpick for the specific example you have here: The
Lenovo ThinkPad T14s does not actually have a "M.2 Mechanical Key E
connector". If you look at a picture of the mainboard [1], the WLAN/BT
module is "soldered-down" (look on the right, on the right side next to
the large copper bracket). In the M.2 specification, "soldered-down"
modules do not have a "key", they have a specific pinout that is
followed (see section 5.4). The power sequencing etc and the set of pins
is quite similar/the same though.

My notes (from a few months ago) suggest the T14s probably uses a
non-standard M.2 Type 1620 LGA pinout. I don't remember the exact chain
of thought behind that, but you can find similarly looking modules with
this type, e.g. https://www.sparklan.com/product/wnsq-290be/. There is a
1620 *BGA* pinout in the M.2 specification, but a 1620 *LGA* pinout does
not exist there. Interestingly, in the block diagram of the module in
the link above this type is called *Q*M.2 1620 LGA 168 pin, as if this
is some Qualcomm-specific form factor.

A real mechanical key E connector can be found e.g. in the X1E CRD, X1E
Devkit, or I think some of the X1E-based HP laptops (would need to check
which one exactly).

I'm not sure if it's really appropriate modeling the "soldered-down"
variant as "Mechanical Key E connector" in the DT. We might need
a separate compatible for this. Do you have any thoughts about that?

Thanks,
Stephan

[1]: https://www.notebookcheck.com/fileadmin/_processed_/d/c/csm_DSC_0003_aadae1ddd2.jpg

