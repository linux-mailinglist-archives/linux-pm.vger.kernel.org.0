Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B136B049C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 11:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCHKgY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 05:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjCHKgN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 05:36:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DC2960B1
        for <linux-pm@vger.kernel.org>; Wed,  8 Mar 2023 02:35:44 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id da10so63849873edb.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Mar 2023 02:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1678271739;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrutnpDgoT44BR3lMhCn+9UB/OdwfGTeStqsfMqeXBc=;
        b=wh3aa4lZBBJtpgaY9rceKyAkYE7TNfdj9IILQRAEG63UOotDpqzzeIjX0+oghko353
         12TPwM49sUAasb8C+OiT5h8IjBs+3ED13XvJzbZkIQQf1e8gQE4fYt+JX4Cfw0Gs+xR7
         E0XTzunurV0Cl1fN48YKRz0DfReC+OxNIcdfkq73ZEqaA7HODJ6LqXUrJRRy8/Owvd2V
         GAMrik6NsiDYrN8UX79l5kChpJLYfo3pc9sRY/1mlr4WgWm/VBY9M7aj7QlV7Vsk3AT9
         Bzburrunc0RoA3PMrd8hEiyvX32xDk9T0sCoeY4ubHqNEX26fYfWP88rsdrZz8tpb8w3
         WnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271739;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BrutnpDgoT44BR3lMhCn+9UB/OdwfGTeStqsfMqeXBc=;
        b=afHaHq+y5C/VlYE8c2QqTg4jtUtTJoU7X4QKmUeSG5gDqcnMl4cMuDvzEioKy7efgh
         pZdI+wuQaO+gnYoxkvMzhaMYkbbeXgPy6JHeUqkdZ3oQas1QKZD2DZQgx7Kz0/uI6bzY
         Ac5lL6g+bj1QZKYOqOJHyolX8aDEwOs2PXqFHGVMXqm4DEB2bsS1iokCvGeQIvntEp7z
         vclycC+lkW+yrbEMbKpuxpqRDg7WG75e6qm9Ho/e0peIcougt7xZ+Aq2gmTTkA+KCe0w
         1biaR7OefrfRlyTQQx9ZehSnh1mG7pIihscNK6REGrTM4bkklE/Nxq/ZV9+8eXHKldan
         5snQ==
X-Gm-Message-State: AO0yUKW9I0pM+/jGb/prAPPmhLxDRxDNAl8EEdyYNYrOG9ABEiQ9Xgmi
        m8aB4xelunikvrnDfYun/pQcJj9GwJWVe7jfkmw29Q==
X-Google-Smtp-Source: AK7set/jCxIzhmK+dO4U0mZ85q9JkzsPf8DcUXlnfpQw8XFXkf4U/5eh2MRcLy98P595UMQQVMAN1A==
X-Received: by 2002:a17:906:db05:b0:8ec:4334:fe with SMTP id xj5-20020a170906db0500b008ec433400femr22619565ejb.26.1678271739617;
        Wed, 08 Mar 2023 02:35:39 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id de19-20020a1709069bd300b008ec4333fd65sm7288413ejc.188.2023.03.08.02.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:35:39 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 08 Mar 2023 11:35:38 +0100
Message-Id: <CR0XOHAGQL77.17W7Q78MY85JL@otso>
Cc:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: sm6350: Add SoC-specific
 compatible to cpufreq_hw
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
 <20230308-topic-cpufreq_bindings-v1-7-3368473ec52d@linaro.org>
In-Reply-To: <20230308-topic-cpufreq_bindings-v1-7-3368473ec52d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Konrad,

On Wed Mar 8, 2023 at 2:27 AM CET, Konrad Dybcio wrote:
> Add a SoC-specific compatbile to cpufreq_hw for compliancy with bindings.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/q=
com/sm6350.dtsi
> index 1e1d366c92c1..c18ca947618e 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1995,7 +1995,7 @@ osm_l3: interconnect@18321000 {
>  		};
> =20
>  		cpufreq_hw: cpufreq@18323000 {
> -			compatible =3D "qcom,cpufreq-hw";
> +			compatible =3D "qcom,sm6350-cpufreq-hw", "qcom,cpufreq-hw";
>  			reg =3D <0 0x18323000 0 0x1000>, <0 0x18325800 0 0x1000>;
>  			reg-names =3D "freq-domain0", "freq-domain1";
>  			clocks =3D <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
>
> --=20
> 2.39.2

