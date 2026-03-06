Return-Path: <linux-pm+bounces-43850-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCW8I/fzqmkjZAEAu9opvQ
	(envelope-from <linux-pm+bounces-43850-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:34:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11850223DF4
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 16:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77DC430603D9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672573E8C4E;
	Fri,  6 Mar 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4XXnpfP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943A3E715D;
	Fri,  6 Mar 2026 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772811215; cv=none; b=aRohbDL3nVaYnQ4/Ge32csqObeL3vSUQ8aYe2lZkhoicA8OYY6BL2B4YlR5GwRWjYA3wRMtZZWxGwgDb6X41yJfBklBuokhNZj3U7jF8N0d2VJZI7/FkEN+C6FEqgrUC7JoFxD895pz5UKZIC1LmkGSNQH5urSHigzACGjKkHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772811215; c=relaxed/simple;
	bh=VM5jbbGTb0mqnwyWcHUzkPKmk0u7/AzwDkbCmqWKtsg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GfYg4KNPn2JUIgy+rNSeja9QjN8C2KdoOVPIcdGo996h9IqyVmp3VLHVrrW61Bqma8jJAJSmfIR8Oo9cxc6O9sbBcU5Kpjg4n5rSPeTO2BEWGjBHmB7W2pU0HHO+EPhbTN9u4QFXxzZ9xlq0BxfBQxGnV1j1lpaMHVDphhuHLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4XXnpfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF108C2BCB1;
	Fri,  6 Mar 2026 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772811215;
	bh=VM5jbbGTb0mqnwyWcHUzkPKmk0u7/AzwDkbCmqWKtsg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=j4XXnpfPZ+hwL9bNlD6tbPv5I3QLjCwJyb+3AHIFuZWfvRJgODvpnDj+LzkZajc4+
	 0VyIjO2rJNiFF49Q6PDx7iuFTaJanGLFkdEBHsvut88pPF0sZ0hQ+Ph4WlQhkCzYZS
	 icgq8uaVua8G7y4YjnoZm+FaRRJzXBbvoH5m66N8fid0T/GGLTWdCqDesuci3ekkRa
	 K2S+9K2HeGMCu57hxH5QnFyVdXg45pksRrpyHQgdTS3pPL8bkaXFg8tn3rMrQmJvdh
	 e3fncahz9DeI23JJQsgy31+Prb1wIsRrIK0/7TqraZrbiaBKHqh+wV/QbVkmoqPjMb
	 P6657wk5PE9lw==
Date: Fri, 06 Mar 2026 09:33:32 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-rtc@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Lee Jones <lee@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-gpio@vger.kernel.org, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260306133351.31589-3-clamor95@gmail.com>
References: <20260306133351.31589-1-clamor95@gmail.com>
 <20260306133351.31589-3-clamor95@gmail.com>
Message-Id: <177281121286.2318682.8615584882799605185.robh@kernel.org>
Subject: Re: [PATCH v3 2/6] dt-binding: pinctrl: pinctrl-max77620: convert
 to DT schema
X-Rspamd-Queue-Id: 11850223DF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43850-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,bootlin.com,intel.com,gmail.com,samsung.com,arm.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,devicetree.org:url]
X-Rspamd-Action: no action


On Fri, 06 Mar 2026 15:33:47 +0200, Svyatoslav Ryhel wrote:
> Convert pinctrl-max77620 devicetree bindings for the MAX77620 PMIC from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../pinctrl/maxim,max77620-pinctrl.yaml       |  97 +++++++++++++
>  .../bindings/pinctrl/pinctrl-max77620.txt     | 127 ------------------
>  2 files changed, 97 insertions(+), 127 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinctrl.yaml: patternProperties:^(pin_gpio|gpio)[0-7_]+$:properties:pins: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/maxim,max77620-pinctrl.yaml: patternProperties:^(pin_gpio|gpio)[0-7_]+$:properties:pins: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260306133351.31589-3-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


