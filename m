Return-Path: <linux-pm+bounces-18366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A46979E085D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 17:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41273170EA3
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF295178CC8;
	Mon,  2 Dec 2024 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLhb4XZr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37FC13B797;
	Mon,  2 Dec 2024 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156212; cv=none; b=Kap1nYpNS2gXSkSb/6KHRUtAYe8A0n+JFW3cHGS8PpLAojDYlJfr4jTzZaNsUMn83KrvbnbU0xP/3aI9AlXyetjp8djGpss7Dk+jTLkwhHvu7RThdL9OypiSKrmXUI1dzJE0nDDgo8+Ykn5Jb6kBOuZ7VJf2Tw1D0nCCyO3Q3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156212; c=relaxed/simple;
	bh=DWFL09z1J64BfAXn8YMn9UGDThioP/LSRTugwMav8u4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=uaiiMHGXREB9BinavV9q1mAzDzDrRTJGcFn8Hy70I7/o6W5FojtxLevJTbamfmhllRadJB0yIqbreTWa8WtQ8H9H0PxIJnaW86zNiHBPKQKYzBMs1Jz7X/Hz0ifBuUIA20K3JHgTlstBTmKGHI4B/c2lnNcT35rC822DOEVoRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLhb4XZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10764C4CED1;
	Mon,  2 Dec 2024 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733156212;
	bh=DWFL09z1J64BfAXn8YMn9UGDThioP/LSRTugwMav8u4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=kLhb4XZrjUxlPTywimQb+87Ep9XgUAE0Z1Tf4DEVrvQSAw8h6++heu3sCe5o6AuJS
	 absKvHrsSrhHdH3f7/JPheaMEx0PFtdGHkDzgHVJCV9u/eoPFh3g5Q3shdUFON68J9
	 p4okSY4oT1iBsAQN1ZhcoV6l/XjmhLwlr1nmnkJMq43722MzUWVvFHbPto7xGZoBz1
	 pp6TYJiZMg9lTZsKVcsu1LSxlFUCnvnx/8jNc3/Ugz8iab5ObNmfzVkAmTXasUvN3+
	 NknDj4tPA/fpobA1w68yAUnM/vVaN9U7LwVQO3iLPxc3bBRvB+qWHr96t8PCM1ZOxv
	 Y+yxFsf8M/jiA==
Date: Mon, 02 Dec 2024 10:16:50 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, 
 upstream@airoha.com, linux-pm@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20241202151228.32609-1-ansuelsmth@gmail.com>
References: <20241202151228.32609-1-ansuelsmth@gmail.com>
Message-Id: <173315621067.2847395.10872023371219236097.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Document support for
 Airoha EN7581 CPUFreq


On Mon, 02 Dec 2024 16:12:03 +0100, Christian Marangi wrote:
> Document required property for Airoha EN7581 CPUFreq .
> 
> On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> to ATF and no clocks are exposed to the OS.
> 
> The SoC have performance state described by ID for each OPP, for this a
> Power Domain is used that sets the performance state ID according to the
> required OPPs defined in the CPU OPP tables.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v4:
> - Add this patch
> 
>  .../cpufreq/airoha,en7581-cpufreq.yaml        | 259 ++++++++++++++++++
>  1 file changed, 259 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.example.dtb: /: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.example.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.example.dtb: opp-table-cpu-smcc: $nodename:0: 'opp-table-cpu-smcc' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.example.dtb: opp-table-cpu-smcc: Unevaluated properties are not allowed ('opp0', 'opp1', 'opp10', 'opp11', 'opp12', 'opp13', 'opp14', 'opp2', 'opp3', 'opp4', 'opp5', 'opp6', 'opp7', 'opp8', 'opp9' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241202151228.32609-1-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


