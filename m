Return-Path: <linux-pm+bounces-34255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A975FB4FBE4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691404E789F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A1233CEAE;
	Tue,  9 Sep 2025 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3qhI7PO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E833CE91;
	Tue,  9 Sep 2025 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422564; cv=none; b=kHVOyFpozG6dLGiHRyx9wZzvzkErPIu52nlyW4hz92Lv4mFCLWTqgne43d9a0qr+6RXhnWuAUBGjwLMEKY7HPRuVbIAtotQXof1zY3YhbD1P47wSqUyYG4SXVwZCS2zEoiRB7rjhUB6oNPsUoeqZt7HPq0SGLMSVn3XqmaFh4xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422564; c=relaxed/simple;
	bh=dEbiJCzUJjUkv7FtdIGkG0u/IXyGk7k7CUmA7DJ3GEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kx2Vxw5E4wKdjrOL9WwUmgH2MJ5jhIWVgV8Uc1BTIBC5PiUPU4wzpBJ3ZNAzV1j2j4fNNFBUZL7QTpvIVC364ltNzGV5X26y2fdQ5XmSxzdcea9oHzWqyD89adSy2T/aWwKKBj2ewXuUcR6Xp8yMxgFZsao/vnRmHVQGDWIRTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3qhI7PO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so3913539f8f.3;
        Tue, 09 Sep 2025 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757422561; x=1758027361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bs6PSVWsZetmovjDd8/UQOAALgqwhMIdtJCi5l1e3lk=;
        b=b3qhI7POUuAEvt5OJ79sN9n4Yp0r+YYP9T0sgvreCIFUjXnXQ21mCT+dk4ls9AJbSe
         o/lOEHcr7+cXAW8yKgujIovRbKLaLD5zq5+6UbNmh+lPFjghvNvATRzIxNqvFmQ8aJYx
         4Q2RKclkxJ1PdqDzzUZ6G848dzqf1xCNml6SZVo8cGJIqJFKLsoJ9xFpqhtXcYh3/pa0
         GGTitmQLNFk1ngpHwo9SoySkhOzYTKd2GaBNrYwzw7CnCwOhH1m9qkVUD9ETKtx5l2la
         oHGJ+gDcvafxeV/O7CqF//eR5zPAXACVxasOs+WaG9FLklXGqIWV7AD5hPX2HPImv0Mg
         xzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757422561; x=1758027361;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bs6PSVWsZetmovjDd8/UQOAALgqwhMIdtJCi5l1e3lk=;
        b=gP+x8YPSZIApTzDou/SoKg8gbtGPq0T4srpR0obGJz6bfWBWKoHjajW/yrEePVaXf/
         uaDY/0wzjMLwz0DADejL6IBCiZpIYd2iy0YH6D26GIIArknpY2vUDI/WQoa4K9pFcTmf
         bpTR7uNUvfVkEXkaDomC0C7JSR0cWbO4Q2V99ctE14hWa7KjvVbxe8F4lnqvgXrhcq+0
         FOIMVNHXH9vaScHXQs1xqbzE9YrPm7LfDgfd46clV4v2uGjR6HcUINf25K6hAmGEWup4
         H+oGoH35mKtvi9RqR0ADrI6ro4WvUkYM30eJDyvYJaR06S/PVmVCuySkE/V5TChHmCop
         +8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdv+rg5nXG2vpl7SPGRwVDr34JhPxpXGRVvtHF4rMG193KzXL+8NMmbA3V8FQ7ckSnZol1Pc6fLUo8VZfN@vger.kernel.org, AJvYcCW1Tui6iiXfpVezSJOc7EGL7GTCoUrWKRdRuBm0jtLE/JmiYrQsymPUOVHeMZsN8oUuMv2/EEYYwzI=@vger.kernel.org, AJvYcCX2X2hnzDldCCzmkj88ZjDTeU3XrTzKWUdBUJxPKWKEAZfPHN69m7BI5803Whl19nkWsVTZWUtCxlhv@vger.kernel.org, AJvYcCXnhNbFcj50ZXKk59syg23tJW72qMCsGVCvB4CgMJpgJU3PUHN8xvgN1m1ghN9k3O6l8A/MNcmy@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdOwDfL8sBodT6H/auMSUZg4gbM91+PB+TRe9Ax+8zRKRr6gT
	ZReyGAr4kAnyvzA9N39KrnbHn3tvXao8BvdYvEOjNfoz5dfjCcwMpmMM
X-Gm-Gg: ASbGnct2Uytn5Dz9KTCX5dtOBfa6NWjZ02NOP05VMxmpn9zxa+bkAMgQD6pKKNMk4Uc
	J/q4tF7/mDbQd+0YCA78Z8Zduu9SObMKCIRMXMEQeXSYiRKh013Ewh072mrpVw8kWfHU7Kx977E
	bT8clLy6mz/PMQHn2tONYrC/3Cftc0ELKzvS9DHROiBHYE+0ZilRNXfm37ZIqyeqxGwy7DxEyAk
	rvCixCqtIgviVbhM0J4uyyD1Z5IIz24+CQXg9jjeUPRDZyuG0I30SsSFh0EKbqzLwx4a4xIwh3+
	thr5TLyLnJCfYTDPmI4rHM+SXACo0yEE3UVebgFGuH8BoTfW1NgYkAjV3gx+Gf1tZGZgvlgLtk8
	QCqFy0iLI7TbwZ7+i5Flmy3vK4iCbUVA=
X-Google-Smtp-Source: AGHT+IHWoxi8ul5BBsyoKDm8D0Ls7ROcCv3GjqOTzlR0eW/G4T6hIVWnLPePdLCCK8/yFYt8oIKJrg==
X-Received: by 2002:a05:6000:40c9:b0:3e5:4ad:2b38 with SMTP id ffacd0b85a97d-3e642309230mr8046948f8f.9.1757422560962;
        Tue, 09 Sep 2025 05:56:00 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca2ddsm2628865f8f.23.2025.09.09.05.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 05:55:59 -0700 (PDT)
Message-ID: <ee677e0d-b63f-412c-8dbf-c3623ca70407@gmail.com>
Date: Tue, 9 Sep 2025 14:55:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] further mt7988 devicetree work
To: Frank Wunderlich <linux@fw-web.de>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Johnson Wang <johnson.wang@mediatek.com>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Landen Chao <Landen.Chao@mediatek.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Felix Fietkau <nbd@nbd.name>
Cc: Frank Wunderlich <frank-w@public-files.de>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250709111147.11843-1-linux@fw-web.de>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20250709111147.11843-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Queued patches 7 - 13

Thanks!

On 09/07/2025 13:09, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This series continues mt7988 devicetree work
> 
> - Extend cpu frequency scaling with CCI
> - GPIO leds
> - Basic network-support (ethernet controller + builtin switch + SFP Cages)
> 
> depencies (i hope this list is complete and latest patches/series linked):
> 
> support interrupt-names is optional again as i re-added the reserved IRQs
> (they are not unusable as i thought and can allow features in future)
> https://patchwork.kernel.org/project/netdevbpf/patch/20250619132125.78368-2-linux@fw-web.de/
> 
> needs change in mtk ethernet driver for the sram to be read from separate node:
> https://patchwork.kernel.org/project/netdevbpf/patch/c2b9242229d06af4e468204bcf42daa1535c3a72.1751461762.git.daniel@makrotopia.org/
> 
> for SFP-Function (macs currently disabled):
> 
> PCS clearance which is a 1.5 year discussion currently ongoing
> 
> Daniel asked netdev for a way 2 go:
> https://lore.kernel.org/netdev/aEwfME3dYisQtdCj@pidgin.makrotopia.org/
> 
> e.g. something like this (one of):
> * https://patchwork.kernel.org/project/netdevbpf/patch/20250610233134.3588011-4-sean.anderson@linux.dev/ (v6)
> * https://patchwork.kernel.org/project/netdevbpf/patch/20250511201250.3789083-4-ansuelsmth@gmail.com/ (v4)
> * https://patchwork.kernel.org/project/netdevbpf/patch/ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org/
> 
> full usxgmii driver:
> https://patchwork.kernel.org/project/netdevbpf/patch/07845ec900ba41ff992875dce12c622277592c32.1702352117.git.daniel@makrotopia.org/
> 
> first PCS-discussion is here:
> https://patchwork.kernel.org/project/netdevbpf/patch/8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org/
> some more here:
> https://lore.kernel.org/netdev/20250511201250.3789083-4-ansuelsmth@gmail.com/
> 
> and then dts nodes for sgmiisys+usxgmii+2g5 firmware
> 
> when above depencies are solved the mac1/2 can be enabled and 2.5G phy/SFP slots will work.
> 
> changes:
> v9:
> - dropped patches already applied (cci,gpio-leds,unused pins)
> - added patches to add RSS IRQs, IRQ-names and sram-node for mt7986
>    note: mt7981 does not have a ethernet node yet
> - set minItems for Filogic (MT798x) IRQs/Names to 8
>    needed to update MT7986 binding example because of this
> - add sram:false to non-Filogic SoCs
> 
> v8:
> - splitted binding into irq-count and irq-names and updated description
> - fixed typo in mt7621 section "interrupt-namess"
> - splitted binding changes into fixes (mac) and additions (sram)
> - dropped change of reg (simple count to description)
> - change ethernet register size to 0x40000
> 
> v7:
> - fixed rebasing error while splitting dt-binding patch
> 
> v6:
> binding:
> - split out the interrupt-names into separate patch
> - update irq(name) min count to 4
> - move interrupt-names up
> - add sram-property
> - drop second reg entry and minitems as there is only 1 item left
> 
> dts:
> - fix whitespace-errors for pdma irqs (spaces vs. tabs)
> - move sram from eth reg to own sram node (needs CONFIG_SRAM)
> 
> v5:
> - add reserved irqs and change names
> - update binding for 8 irqs with different names (rx,tx => fe1+fe2, rx-ringX => pdmaX)
>    (dropped Robs RB due to this change again, sorry)
> 
> v4:
>    net-binding:
>      - allow interrupt names and increase max interrupts to 6 because of RSS/LRO interrupts
>        (dropped Robs RB due to this change)
> 
>    dts-patches:
>    - add interrupts for RSS/LRO and interrupt-names for ethernet node
>    - eth-reg and clock whitespace-fix
>    - comment for fixed-link on gmac0
>    - drop phy-mode properties as suggested by andrew
>    - drop phy-connection-type on 2g5 board
>    - reorder some properties
>    - update 2g5 phy node
>      - unit-name dec instead of hex to match reg property
>      - move compatible before reg
>      - drop phy-mode
> 
> v3:
>    - dropped patches already applied (SPI+thermal)
>    - added soc specific cci compatible (new binding patch + changed dts)
>    - enable 2g5 phy because driver is now merged
>    - add patch for cleaning up unnecessary pins
>    - add patch for gpio-leds
>    - add patch for adding ethernet aliases
> 
> v2:
>    - change reg to list of items in eth binding
>    - changed mt7530 binding:
>      - unevaluatedProperties=false
>      - mediatek,pio subproperty
>      - from patternProperty to property
>    - board specific properties like led function and labels moved to bpi-r4 dtsi
> 
> Frank Wunderlich (13):
>    dt-bindings: net: mediatek,net: update mac subnode pattern for mt7988
>    dt-bindings: net: mediatek,net: allow up to 8 IRQs
>    dt-bindings: net: mediatek,net: allow irq names
>    dt-bindings: net: mediatek,net: add sram property
>    dt-bindings: net: dsa: mediatek,mt7530: add dsa-port definition for
>      mt7988
>    dt-bindings: net: dsa: mediatek,mt7530: add internal mdio bus
>    arm64: dts: mediatek: mt7986: add sram node
>    arm64: dts: mediatek: mt7986: add interrupts for RSS and interrupt
>      names
>    arm64: dts: mediatek: mt7988: add basic ethernet-nodes
>    arm64: dts: mediatek: mt7988: add switch node
>    arm64: dts: mediatek: mt7988a-bpi-r4: add aliases for ethernet
>    arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
>    arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds
> 
>   .../bindings/net/dsa/mediatek,mt7530.yaml     |  24 +-
>   .../devicetree/bindings/net/mediatek,net.yaml |  64 +++-
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |  20 +-
>   .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts  |  11 +
>   .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  |  19 ++
>   .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi |  86 ++++++
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 285 +++++++++++++++++-
>   7 files changed, 497 insertions(+), 12 deletions(-)
> 


