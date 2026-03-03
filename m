Return-Path: <linux-pm+bounces-43518-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCC3FSANp2k0cwAAu9opvQ
	(envelope-from <linux-pm+bounces-43518-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 17:32:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD70D1F3D9B
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 17:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC5A7305A6F3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D1494A1D;
	Tue,  3 Mar 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lylUKGGk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34CA3C2793;
	Tue,  3 Mar 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555191; cv=none; b=Sl8HA/3ZC7I6I2gDy0KKELEM++chyDwnRGIQ7Q0yYuNnaWHXnG6OXKoo89PWHSUrZLb17d2aHrWU+VsxtPABWyOfVDaRHXln8EYzHsE9L01u2BYyS9rYzH7bemRvz/W8n3JmMujt8bRVBq3oNR1nQNN+GCLjvsNGOwJIZDaZUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555191; c=relaxed/simple;
	bh=CNof27mBd7wDf5xVAmiF83SJwHYfTGHuU1OvIIJqavM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=sluP1TsCE15FaUnsAkK67Q17V9Tq75N9otWpHXJtD55WgBY/2AeqkRAETXWeVv9NCHpOSWBLUIkFhpcgFU3CRaZORtaGtaNwaP4aRgrUbh027arj3AQKJnPDvaTErNQ2lwdoyOJkO4qiz/2ONKZF4Jsu3QGdj6tGvlfj4Qw9bTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lylUKGGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7122FC116C6;
	Tue,  3 Mar 2026 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555191;
	bh=CNof27mBd7wDf5xVAmiF83SJwHYfTGHuU1OvIIJqavM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=lylUKGGk1Z4QWPsJvE3c0aZaw7lLVxGzIFr3G6NLL5nzncLwG0jjky3MI96HllUhO
	 GAbziDezN4B5SrzxMzX2vk+WqyPgCpxXR7tCjx0JnFldU+RqctcMM5gIE12lkOJeL1
	 9jh4YfNT1U058uUj+DCw5xbX5RDmEUALuLHT+F2ATs3ZqU05ft6rqx0O5xjFpo/Jl2
	 FUflsZD9HbSHhDEmY+LRAkOHhFCIWibT1plvQ5Y2fhicm4CxIdnfx6kyQrElqY/TFz
	 83l01dHPENFtSljUdFVf9KOZUtfIhU7YDSXiTGccqEMPBYOB25aIkEA14y05PiaAt+
	 La63c7PM674OA==
Date: Tue, 03 Mar 2026 10:26:30 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org
To: Alexey Charkov <alchark@flipper.net>
In-Reply-To: <20260303-bq25792-v1-1-e6e5e0033458@flipper.net>
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
 <20260303-bq25792-v1-1-e6e5e0033458@flipper.net>
Message-Id: <177255519061.3485716.8870568133764595988.robh@kernel.org>
Subject: Re: [PATCH 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include
 BQ25792
X-Rspamd-Queue-Id: AD70D1F3D9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-43518-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,hotmail.com,gmail.com,collabora.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	NEURAL_SPAM(0.00)[0.723];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,6b:email]
X-Rspamd-Action: no action


On Tue, 03 Mar 2026 19:32:46 +0400, Alexey Charkov wrote:
> TI BQ25792 is similar in operation to BQ25703A, but has a different
> register layout and different current/voltage capabilities.
> 
> Expand the existing BQ25703A binding to include BQ25792, and move the
> voltage and current limits into per-variant conditional statements.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  .../devicetree/bindings/mfd/ti,bq25703a.yaml       | 79 +++++++++++++++++-----
>  1 file changed, 62 insertions(+), 17 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml: ignoring, error in schema: properties: allOf
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml: properties: 'allOf' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml: properties:allOf: [{'if': {'properties': {'compatible': {'const': 'ti,bq25703a'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 500000, 'maximum': 6350000, 'default': 5000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-min-microvolt': {'minimum': 4480000, 'maximum': 20800000}, 'regulator-max-microvolt': {'minimum': 4480000, 'maximum': 20800000}}}}}}}}, {'if': {'properties': {'compatible': {'const': 'ti,bq25792'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 1000000, 'maximum': 3300000, 'default': 3000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-min-mic
 rovolt': {'minimum': 2800000, 'maximum': 22000000}, 'regulator-max-microvolt': {'minimum': 2800000, 'maximum': 22000000}}}}}}}}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml: properties:allOf: [{'if': {'properties': {'compatible': {'const': 'ti,bq25703a'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 500000, 'maximum': 6350000, 'default': 5000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-min-microvolt': {'minimum': 4480000, 'maximum': 20800000}, 'regulator-max-microvolt': {'minimum': 4480000, 'maximum': 20800000}}}}}}}}, {'if': {'properties': {'compatible': {'const': 'ti,bq25792'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 1000000, 'maximum': 3300000, 'default': 3000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-min-mic
 rovolt': {'minimum': 2800000, 'maximum': 22000000}, 'regulator-max-microvolt': {'minimum': 2800000, 'maximum': 22000000}}}}}}}}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml: properties:allOf: [{'if': {'properties': {'compatible': {'const': 'ti,bq25703a'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 500000, 'maximum': 6350000, 'default': 5000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-min-microvolt': {'minimum': 4480000, 'maximum': 20800000}, 'regulator-max-microvolt': {'minimum': 4480000, 'maximum': 20800000}}}}}}}}, {'if': {'properties': {'compatible': {'const': 'ti,bq25792'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 1000000, 'maximum': 3300000, 'default': 3000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-min-mic
 rovolt': {'minimum': 2800000, 'maximum': 22000000}, 'regulator-max-microvolt': {'minimum': 2800000, 'maximum': 22000000}}}}}}}}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml: properties:allOf: [{'if': {'properties': {'compatible': {'const': 'ti,bq25703a'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 500000, 'maximum': 6350000, 'default': 5000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-min-microvolt': {'minimum': 4480000, 'maximum': 20800000}, 'regulator-max-microvolt': {'minimum': 4480000, 'maximum': 20800000}}}}}}}}, {'if': {'properties': {'compatible': {'const': 'ti,bq25792'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 1000000, 'maximum': 3300000, 'default': 3000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-min-mic
 rovolt': {'minimum': 2800000, 'maximum': 22000000}, 'regulator-max-microvolt': {'minimum': 2800000, 'maximum': 22000000}}}}}}}}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml: properties:allOf: [{'if': {'properties': {'compatible': {'const': 'ti,bq25703a'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 500000, 'maximum': 6350000, 'default': 5000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-min-microvolt': {'minimum': 4480000, 'maximum': 20800000}, 'regulator-max-microvolt': {'minimum': 4480000, 'maximum': 20800000}}}}}}}}, {'if': {'properties': {'compatible': {'const': 'ti,bq25792'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 1000000, 'maximum': 3300000, 'default': 3000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-min-mic
 rovolt': {'minimum': 2800000, 'maximum': 22000000}, 'regulator-max-microvolt': {'minimum': 2800000, 'maximum': 22000000}}}}}}}}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml: properties:allOf: [{'if': {'properties': {'compatible': {'const': 'ti,bq25703a'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 500000, 'maximum': 6350000, 'default': 5000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-min-microvolt': {'minimum': 4480000, 'maximum': 20800000}, 'regulator-max-microvolt': {'minimum': 4480000, 'maximum': 20800000}}}}}}}}, {'if': {'properties': {'compatible': {'const': 'ti,bq25792'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 1000000, 'maximum': 3300000, 'default': 3000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-min-mic
 rovolt': {'minimum': 2800000, 'maximum': 22000000}, 'regulator-max-microvolt': {'minimum': 2800000, 'maximum': 22000000}}}}}}}}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml: properties:allOf: [{'if': {'properties': {'compatible': {'const': 'ti,bq25703a'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 500000, 'maximum': 6350000, 'default': 5000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-min-microvolt': {'minimum': 4480000, 'maximum': 20800000}, 'regulator-max-microvolt': {'minimum': 4480000, 'maximum': 20800000}}}}}}}}, {'if': {'properties': {'compatible': {'const': 'ti,bq25792'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 1000000, 'maximum': 3300000, 'default': 3000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-min-mic
 rovolt': {'minimum': 2800000, 'maximum': 22000000}, 'regulator-max-microvolt': {'minimum': 2800000, 'maximum': 22000000}}}}}}}}] is not of type 'object', 'boolean'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml: properties:allOf: [{'if': {'properties': {'compatible': {'const': 'ti,bq25703a'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 500000, 'maximum': 6350000, 'default': 5000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 6350000}, 'regulator-min-microvolt': {'minimum': 4480000, 'maximum': 20800000}, 'regulator-max-microvolt': {'minimum': 4480000, 'maximum': 20800000}}}}}}}}, {'if': {'properties': {'compatible': {'const': 'ti,bq25792'}}}, 'then': {'properties': {'input-current-limit-microamp': {'minimum': 1000000, 'maximum': 3300000, 'default': 3000000}, 'regulators': {'properties': {'vbus': {'properties': {'regulator-min-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-max-microamp': {'minimum': 0, 'maximum': 3320000}, 'regulator-min-mic
 rovolt': {'minimum': 2800000, 'maximum': 22000000}, 'regulator-max-microvolt': {'minimum': 2800000, 'maximum': 22000000}}}}}}}}] is not of type 'object', 'boolean'
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 8, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 66, in main
    ret |= check_doc(f)
           ~~~~~~~~~^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/doc_validate.py", line 37, in check_doc
    dtsch.check_schema_refs()
    ~~~~~~~~~~~~~~~~~~~~~~~^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 241, in check_schema_refs
    self._check_schema_refs(resolver, self)
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 212, in _check_schema_refs
    self._check_schema_refs(resolver, v, parent=k, is_common=is_common,
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            has_constraint=has_constraint)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 216, in _check_schema_refs
    self._check_schema_refs(resolver, schema[i], parent=parent, is_common=is_common,
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                            has_constraint=has_constraint)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/dtschema/schema.py", line 203, in _check_schema_refs
    ref_sch = resolver.lookup(schema['$ref']).contents
              ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 682, in lookup
    retrieved = self._registry.get_or_retrieve(uri)
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 422, in get_or_retrieve
    registry = self.crawl()
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 500, in crawl
    id = resource.id()
  File "/usr/local/lib/python3.13/dist-packages/referencing/_core.py", line 231, in id
    id = self._specification.id_of(self.contents)
  File "/usr/local/lib/python3.13/dist-packages/referencing/jsonschema.py", line 50, in _dollar_id
    return contents.get("$id")
           ^^^^^^^^^^^^
AttributeError: 'list' object has no attribute 'get'
Documentation/devicetree/bindings/mfd/ti,bq25703a.example.dtb: /example-0/i2c/charger@6b: failed to match any schema with compatible: ['ti,bq25703a']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260303-bq25792-v1-1-e6e5e0033458@flipper.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


