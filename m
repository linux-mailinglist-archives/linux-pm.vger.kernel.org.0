Return-Path: <linux-pm+bounces-14367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D96297AF8D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 13:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93651F21EE5
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 11:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7382171E68;
	Tue, 17 Sep 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK2oTKhU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA027171650;
	Tue, 17 Sep 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571707; cv=none; b=XMx6qEJtIpowRdiKurqsi6coPP4Fpz/Vjbraezwpnca/mJBmYWrbb35ehxcu+5lJPLI1cI5dTOs7dDgKL0nkeIZH3IpvCpqZ9Wt4Hlux/TXT7I+VB8rHOtIBCIxnwwszlchT8uaN5DweunxdfEffzGuo++HEIhu1PDUg4nvIz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571707; c=relaxed/simple;
	bh=/dzXGXN7SpKLAErSAYQKoA0kf+pgmBde2DR3bA+cqZc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=U2dHBVq3RTyRdxlvNkWiNV7lvwVyy9M0ql2pa/9m92hq4Niu+XIQrYYKRKIK+WFGhbax42Pv+SHZlnONrPq9TpNeRnDDGjrGGr6D/C7rzLYWdzBo0MdHysq9EILCEcQz74rLLW/pmSNCL8bRieBRIQMTOH5M2OCKhILnrch89dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK2oTKhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B8FC4CEC5;
	Tue, 17 Sep 2024 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726571707;
	bh=/dzXGXN7SpKLAErSAYQKoA0kf+pgmBde2DR3bA+cqZc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GK2oTKhUsx6QAkvWuJQE/itSMUmYCkBf9WnVDw05nyqiO2NoBFKinRaNyIJETg8Dh
	 sRdWmEhVBYEWs1l/JGVfeduq9Xivc9i53XHexh0PRW9h0nR8/nzGXoidyHLNKwjpHf
	 UbEtD2RLzAy3dZxl11fDR+7H3/Qr2FzHLX+t1jcEhQ30bpDdNsAvpIne7MfDVMtREi
	 VPxoyqUIMRIWIAGGEXWUeH+/h0ucWikOLJhcjzj97IcozdvX/UHnY3W63skY/S4Vk9
	 wJ6B9GkCwEzyRB6YIx6KwZ5xe2xS9227VZq65Fv5BW5jG1EItgfPpoykTRA1y9kNYl
	 HbJHp6jo/nq7g==
Date: Tue, 17 Sep 2024 06:15:05 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 nm@ti.com, linux-kernel@vger.kernel.org, vigneshr@ti.com, 
 devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>
In-Reply-To: <20240917095252.1292321-1-d-gole@ti.com>
References: <20240917095252.1292321-1-d-gole@ti.com>
Message-Id: <172657170552.2868246.14297688654670188245.robh@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: opp: operating-points-v2-ti-cpu:
 Describe opp-supported-hw


On Tue, 17 Sep 2024 15:22:52 +0530, Dhruva Gole wrote:
> It seems like we missed migrating the complete information from the old
> DT binding where we had described what the opp-supported-hw is supposed
> to describe. Hence, bring back the description from the previous binding
> to the current one along with a bit more context on what the values are
> supposed to be.
> 
> Fixes: e576a9a8603f ("dt-bindings: cpufreq: Convert ti-cpufreq to json schema")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Changes in v3:
> - Use the items: and then provide description for both required items.
>   This tries to address Rob's comments on previous revision.
> - I've not use min/max Items as the 2 descriptions items implicitly
>   imply that number of bitfields needed are 2.
> - Link to v2: https://lore.kernel.org/all/20240905-b4-opp-dt-binding-fix-v2-1-1e3d2a06748d@ti.com/
> 
> Changes in v2:
> - Drop the patch where I updated Maintainers since it's already picked
>   by Viresh.
> - Add more details of how to populate the property based on device
>   documents like TRM/ datasheet.
> - Link to v1: https://lore.kernel.org/r/20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com
> 
> ---
>  .../opp/operating-points-v2-ti-cpu.yaml         | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml:52:13: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml: ignoring, error parsing file
make[2]: *** Deleting file 'Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.example.dts'
Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml:52:13: could not find expected ':'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml:52:13: could not find expected ':'
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1432: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240917095252.1292321-1-d-gole@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


