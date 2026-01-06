Return-Path: <linux-pm+bounces-40304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61173CF7DFB
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 11:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6742A3004428
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D330F7FD;
	Tue,  6 Jan 2026 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8JEB5pQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0097C199E94;
	Tue,  6 Jan 2026 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696559; cv=none; b=JXqC3XxvZ8f0AIoJ8rXb7iRHftxstco4xvCgO/48MB2zoIpPb47Nr5o4cykhOITxOIqt+cmlZ7aPtKJ5VqKMPi4wHbsWX+sG3b9/XLGTiFmh7grWJ9k4ZWB49L0Irt1Ai6rRODG8ALw9x1iAEqYfdxo8fVO3HwG5XMW6dPBVMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696559; c=relaxed/simple;
	bh=Xb+h5SYWWvSkRROTlUNDQfcSyzPkTdiaZXJudKyt/vs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=T41ggahQcy8owWSp63t+jMarcUdpl21gj7v9mKTMSU1Rx4n7zpju69bVHmqujzlmpYI0KVGSBOD/QKUY3Jgt2TnW3X2bclKoVysWmJ4n+WJqGhbXN1j+bM1zAGsoUdI2v6BkKiM0a/7tyJ+QaKXhBtJEhl+NCZ4rwV1h/a2RFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8JEB5pQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778BCC116C6;
	Tue,  6 Jan 2026 10:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767696558;
	bh=Xb+h5SYWWvSkRROTlUNDQfcSyzPkTdiaZXJudKyt/vs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=a8JEB5pQYJ3qSa/sAUCsQA7nnQdcSlB7apzjxcN6PLujcME5h/9mXw2AHYMWsSnh+
	 2O2EGX3V5n9r3ub5Q0JWJQJA9OmtoqjCcnwXCOyfkc4CiJ0wIhFpaL+z9eb1aNZ8pL
	 XPeqyYpLqxJ+iQjH65Ui1fUs4H00hGhTEd2UiDxey5E8/FihsdMRMrgkBaDcNO371N
	 Y23tR7ERbOFXOPTDXYQKQv7w85g1LqCWLLbsvrbBaTVjeFS23ySlK/G6zlyU1jjHYI
	 D03iDAPjdFW9fJAqH0mdbaD5RlIRzMOjMn1mUrv3j+xOtkdpVe5cuc4DAXTaqEPu09
	 oHiIEPJsQuwlA==
Date: Tue, 06 Jan 2026 04:49:17 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 viresh.kumar@linaro.org, linux-riscv@lists.infradead.org, alex@ghiti.fr, 
 aou@eecs.berkeley.edu, sboyd@kernel.org, palmer@dabbelt.com, 
 krzk+dt@kernel.org, rahul@summations.net, rafael@kernel.org, 
 darshan.prajapati@einfochips.com, anup@brainfault.org, cyy@cyyself.name, 
 jassisinghbrar@gmail.com, michal.simek@amd.com, charlie@rivosinc.com, 
 pjw@kernel.org, dfustini@oss.tenstorrent.com, leyfoon.tan@starfivetech.com, 
 conor+dt@kernel.org, jms@oss.tenstorrent.com
To: Joshua Yeong <joshua.yeong@starfivetech.com>
In-Reply-To: <20260106092117.3727152-2-joshua.yeong@starfivetech.com>
References: <20260106092117.3727152-1-joshua.yeong@starfivetech.com>
 <20260106092117.3727152-2-joshua.yeong@starfivetech.com>
Message-Id: <176769655757.1087310.16557649549419031766.robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: firmware: Add RPMI performance
 service message proxy bindings


On Tue, 06 Jan 2026 17:21:12 +0800, Joshua Yeong wrote:
> Add device tree bindings for the RPMI performance service group based
> message proxy implemented by the SBI implementation (machine mode
> firmware or hypervisor).
> 
> The RPMI performance service group is defined by the RISC-V Platform
> Management Interface (RPMI) specification.
> 
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---
>  .../firmware/riscv,rpmi-mpxy-performance.yaml | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/riscv,rpmi-mpxy-performance.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Warning: Duplicate compatible "riscv,rpmi-mpxy-clock" found in schemas matching "$id":
	http://devicetree.org/schemas/firmware/riscv,rpmi-mpxy-performance.yaml
	http://devicetree.org/schemas/clock/riscv,rpmi-mpxy-clock.yaml#
Documentation/devicetree/bindings/firmware/riscv,rpmi-mpxy-performance.example.dtb: /example-0/performance: failed to match any schema with compatible: ['riscv,rpmi-mpxy-performance']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260106092117.3727152-2-joshua.yeong@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


