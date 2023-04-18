Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2BC6E6BD9
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 20:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjDRSMX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 14:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjDRSMW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 14:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E330E0
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681841488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a2NJ2p6cE8nPnq4qyhSh+ydMCNdO89r7It+YsHhkzyo=;
        b=Lhn27uWv5dupfn729fZlxLNozJcSpFLlPKTmT0vqlfhnMS6uPd8oOiC+yfY4KU8vhlEwRt
        pLrlPlcvbwrwmTvZKlhjmSodVOaICwMfM73ajch5tSbvN5p7jjUZaNWT0RKSnEKwu9w3uR
        hgPWFBcgLTPkJ4WvrWmVUQME4FShi20=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-1xFkmXGrNPS2_TSOIy6FwQ-1; Tue, 18 Apr 2023 14:11:24 -0400
X-MC-Unique: 1xFkmXGrNPS2_TSOIy6FwQ-1
Received: by mail-qv1-f70.google.com with SMTP id t29-20020a0cb39d000000b005ef732729f9so3024983qve.9
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 11:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681841484; x=1684433484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2NJ2p6cE8nPnq4qyhSh+ydMCNdO89r7It+YsHhkzyo=;
        b=WdwSekfqa48Erh5IY7SkVyVOohROuzP9qHPHOXqEVkezIZmn9n76Uoin6j6qRrMo9S
         UBHYLpD6qQwohad6s4x4V1NufwAc1St4QXHDDH+IME+4i1lSp3kdAwbM5c9RRlMeiH6T
         jGD7W+WLb1fZiBGwU1r2dAQqHOZmnDrICRb4Hz/YeQwKgzHhMTWkvWS51qhXw9ajI0Mu
         JUTNODX7uLjG5mD9X7cCr8QVlK49uGliWpi1O7B5JSWKMLw8a7Cl+vZDlf1dusX49bIV
         lD+z4umrXPSFQ0cs/76NAY6zwW7k3RkVCrPVmkpUOUuFYfa+NoQrcJf3PIYL0qyn22hZ
         JFbg==
X-Gm-Message-State: AAQBX9fcj5DLlcVLUWagLiLi0FqcGYL2AqcQuHKFOjLCU5S3gXxgBTNA
        Q8MMUeJf1EcPnqyr5W//6V//R6xFyYbuuXiiT7YIt7HvsHL4/7eD7XAM+Gv/EbAJ0PYXRopPDpj
        Bu9e4wrtqGroPv1pyY+o=
X-Received: by 2002:a05:6214:508b:b0:5e0:7ecb:8ffb with SMTP id kk11-20020a056214508b00b005e07ecb8ffbmr23344893qvb.8.1681841484172;
        Tue, 18 Apr 2023 11:11:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350a3GbO3FdgQzclKEsUIQPHtPQW7EW4y+mIxxoj0/PCOcdeWVYhW6FGqFVxxMO5MsPFGAYyE5w==
X-Received: by 2002:a05:6214:508b:b0:5e0:7ecb:8ffb with SMTP id kk11-20020a056214508b00b005e07ecb8ffbmr23344854qvb.8.1681841483879;
        Tue, 18 Apr 2023 11:11:23 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id kr24-20020a0562142b9800b005eee320b5d7sm3812683qvb.63.2023.04.18.11.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:11:23 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:11:26 -0400
From:   Eric Chanudet <echanude@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sa8775p: pmic: add the sdam_0
 node
Message-ID: <20230418181126.yu7ym5acb3x5twex@echanude>
References: <20230417145536.414490-1-brgl@bgdev.pl>
 <20230417145536.414490-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417145536.414490-4-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 17, 2023 at 04:55:36PM +0200, Bartosz Golaszewski wrote:
> From: Parikshit Pareek <quic_ppareek@quicinc.com>
> 
> Introduce sdam_0 node, which is to be used via nvmem for power on
> reasons during reboot. Add supported PoN reaons supported via sdam_0
> node.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Tested-by: Eric Chanudet <echanude@redhat.com>

> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> index 5abdc239d3a6..3c3b6287cd27 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> @@ -88,6 +88,14 @@ trip1 {
>  			};
>  		};
>  	};
> +
> +	reboot-mode {
> +		compatible = "nvmem-reboot-mode";
> +		nvmem-cells = <&reboot_reason>;
> +		nvmem-cell-names = "reboot-mode";
> +		mode-recovery = <0x01>;
> +		mode-bootloader = <0x02>;
> +	};
>  };
>  
>  &spmi_bus {
> @@ -133,6 +141,19 @@ pmm8654au_0_gpios: gpio@8800 {
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  		};
> +
> +		pmm8654au_0_sdam_0: nvram@7100 {
> +			compatible = "qcom,spmi-sdam";
> +			reg = <0x7100>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x7100 0x100>;
> +
> +			reboot_reason: reboot-reason@48 {
> +				reg = <0x48 0x1>;
> +				bits = <1 7>;
> +			};
> +		};
>  	};
>  
>  	pmm8654au_1: pmic@2 {
> -- 
> 2.37.2
> 

-- 
Eric Chanudet

