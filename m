Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673F945E275
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 22:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbhKYVbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 16:31:33 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42654 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241687AbhKYV3c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 16:29:32 -0500
Received: by mail-oi1-f179.google.com with SMTP id n66so14913242oia.9;
        Thu, 25 Nov 2021 13:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=G/HOoCkE7F4KtFddRguEHWeaPLGWRwjij7xDaewa9ig=;
        b=cjKAjTBisuU4TabmtFy9doiPZ66PP9oF/tHPiZ7BzEVdfbt/spwhB67k1d/f0GuZqT
         AAP2wsvR3oSH4BspI29vTMawDMhiI0fGrv/dZLWlC4lyXCcnPME9lWXNLTg0RaXrHYxp
         m4mteMEmb2sOEoPTMaEIEqFzu3yDTuQppwpcBD8aN4QbB2zQ0zerovPZO09Osjh0pYNP
         NkXKPgbpwIfiw/McNmWynEydGF8/dpEYeokavkcpTzRkuo1j+7yUNcE3Bu8s5B2If2Se
         HefgsHY8H9AmlJ6AjGpRqGxkMYekI0atWwABU4h1P0SMZ7N7uQUiYPCQlhbFoNsEe34Z
         phWg==
X-Gm-Message-State: AOAM532O/oJ7Tfh3oKCo3UXHGQQ5JnLW9zIPNyBUvqLgOOonre5LIq6t
        H0OwPDi5U0OM4vuY/dTUUzvxyQgb9A==
X-Google-Smtp-Source: ABdhPJzppe2WKUD4k7V69gomdFEgKeo+K1tcz1FiRDpp4KvwAgBEkEW8CrnaQh4FKneeTrN151vVVA==
X-Received: by 2002:a05:6808:1392:: with SMTP id c18mr18839736oiw.53.1637875580250;
        Thu, 25 Nov 2021 13:26:20 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s1sm650568ooo.11.2021.11.25.13.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 13:26:19 -0800 (PST)
Received: (nullmailer pid 2858307 invoked by uid 1000);
        Thu, 25 Nov 2021 21:26:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, lukasz.luba@arm.com,
        ulf.hansson@linaro.org, arnd@linaro.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, rjw@rjwysocki.net
In-Reply-To: <20211124125506.2971069-1-daniel.lezcano@linaro.org>
References: <20211124125506.2971069-1-daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/5] dt-bindings: Powerzone new bindings
Date:   Thu, 25 Nov 2021 14:26:02 -0700
Message-Id: <1637875562.234693.2858306.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Nov 2021 13:55:00 +0100, Daniel Lezcano wrote:
> The proposed bindings are describing a set of powerzones.
> 
> A power zone is the logical name for a component which is capable of
> power capping and where we can measure the power consumption.
> 
> A power zone can aggregate several power zones in terms of power
> measurement and power limitations. That allows to apply power
> constraint to a group of components and let the system balance the
> allocated power in order to comply with the constraint.
> 
> The ARM System Control and Management Interface (SCMI) can provide a
> power zone description.
> 
> The powerzone semantic is also found on the Intel platform with the
> RAPL register.
> 
> The Linux kernel powercap framework deals with the powerzones:
> 
> https://www.kernel.org/doc/html/latest/power/powercap/powercap.html
> 
> The powerzone can also represent a group of children powerzones, hence
> the description can result on a hierarchy. Such hierarchy already
> exists with the hardware or can be represented an computed from the
> kernel.
> 
> The hierarchical description was initially proposed but not desired
> given there are other descriptions like the power domain proposing
> almost the same description.
> 
> https://lore.kernel.org/all/CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com/
> 
> The description gives the power constraint dependencies to apply on a
> specific group of logically or physically aggregated devices. They do
> not represent the physical location or the power domains of the SoC
> even if the description could be similar.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../devicetree/bindings/power/powerzones.yaml | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/powerzones.yaml: 'additionalProperties' is a required property
	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/powerzones.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/power/powerzones.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1559118

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

