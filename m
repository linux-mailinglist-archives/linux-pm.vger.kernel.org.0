Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7628C7B6949
	for <lists+linux-pm@lfdr.de>; Tue,  3 Oct 2023 14:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjJCMo6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Oct 2023 08:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjJCMo5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2023 08:44:57 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36542A6
        for <linux-pm@vger.kernel.org>; Tue,  3 Oct 2023 05:44:53 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77409065623so62707985a.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Oct 2023 05:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696337092; x=1696941892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xDj1q+Ee+ORzJ70hRtintqC5xZdcBaiRQa5S4Cdho10=;
        b=WRfTQWpvQp3+AMJ84YUZSAUj2gNVc7Hi3P+fItsZqVcekiIBUL/TLW2hha/Z/y+qYx
         Ypz9th/0xCyj6J6TKhiJptrUgz+mVs8MQ4tpUzYmrtFMab05nANMLSS2wniw43cvALkD
         YzobMSnDKQbJu66dv0HcEZZh/EKJXkIJ3i9/2MzSnNj3IDtBy2dYvSX+8ziIWkN0RQ8Q
         QY3s/UkAvX8CSk/OPGQSjxEVuNzAmagoVfcfiIlC4SBNpZRSjN5GwdXoZBcUCVIALz/t
         M45H8D9ECJKh0ku7Z+xyGPWKOWPliBb7OexwYMGZcHn/7CsQ3uWdIcB3ZKWy2ixoXqlx
         8+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696337092; x=1696941892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDj1q+Ee+ORzJ70hRtintqC5xZdcBaiRQa5S4Cdho10=;
        b=pawtQG7R9oT2ecZhihwPVV8fyfdJB9b9FCAls+wiZAsrTh8Ml3ELq/SN+KWlrCocT9
         ZGD65MAjtsQqpH8IyGSArOK11SX/GVc1jwQMf1JFy3uIvsvSo//Z7ItHCaBpcSWWqlxh
         m3KVbmm1d9duP0IQ3jrzAapPldyHiSiChpv8RWraj+o/++Zt2cVZQU2Bzrb/+nf5nyus
         dCDH7V/0/B+z0/NfZGKYRmu2ZZDl1ybtRmt7Rcplk3MRWuZMkXdpPdNkR4ZDxkPS/xGI
         Q/Rwgpy7kXY0BQjKqvTUPYPH0lRmyipAEWQmGpPIKH0EevV9gBiE4vhQ0SiOR1+Ny29O
         f0Rg==
X-Gm-Message-State: AOJu0YyGOUzMns8JVH6AC0bRr6Q3rSy5FOPiXLPsn09w4sdQ/l8/avjt
        pHpRw3UMfZZ9MBnwNIa/gMF+
X-Google-Smtp-Source: AGHT+IEbRFcGxZgw52UjDfv1LBZdcZLdSA4iZ7N+WH5lAbH4U4/cWa8LNP/L/IMXn2BWS/8z2N+zyQ==
X-Received: by 2002:a05:620a:4007:b0:775:9bc3:c492 with SMTP id h7-20020a05620a400700b007759bc3c492mr9066667qko.7.1696337092194;
        Tue, 03 Oct 2023 05:44:52 -0700 (PDT)
Received: from thinkpad ([117.217.185.220])
        by smtp.gmail.com with ESMTPSA id d15-20020a05620a136f00b007756d233fbdsm425442qkl.37.2023.10.03.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 05:44:51 -0700 (PDT)
Date:   Tue, 3 Oct 2023 18:14:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     quic_narepall@quicinc.com, bmasney@redhat.com,
        krzysztof.kozlowski+dt@linaro.org, quic_nitirawa@quicinc.com,
        vireshk@kernel.org, quic_asutoshd@quicinc.com,
        quic_bhaskarv@quicinc.com, avri.altman@wdc.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        jejb@linux.ibm.com, cw00.choi@samsung.com, andersson@kernel.org,
        bvanassche@acm.org, conor+dt@kernel.org, kyungmin.park@samsung.com,
        martin.petersen@oracle.com, nm@ti.com,
        linux-kernel@vger.kernel.org, quic_richardp@quicinc.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-scsi@vger.kernel.org, myungjoo.ham@samsung.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        sboyd@kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: ufs: common: add OPP table
Message-ID: <20231003124435.GA44736@thinkpad>
References: <20231003111232.42663-1-manivannan.sadhasivam@linaro.org>
 <20231003111232.42663-2-manivannan.sadhasivam@linaro.org>
 <169633539510.282606.1450427416869008072.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169633539510.282606.1450427416869008072.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 03, 2023 at 07:16:35AM -0500, Rob Herring wrote:
> 
> On Tue, 03 Oct 2023 16:42:27 +0530, Manivannan Sadhasivam wrote:
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Except scaling UFS and bus clocks, it's necessary to scale also the
> > voltages of regulators or power domain performance state levels.  Adding
> > Operating Performance Points table allows to adjust power domain
> > performance state, depending on the UFS clock speed.
> > 
> > OPPv2 deprecates previous property limited to clock scaling:
> > freq-table-hz.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/ufs/ufs-common.yaml   | 36 ++++++++++++++++---
> >  1 file changed, 32 insertions(+), 4 deletions(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/ufs/ufs-common.yaml:90:20: [error] string value is redundantly quoted with any quotes (quoted-strings)
> ./Documentation/devicetree/bindings/ufs/ufs-common.yaml:91:26: [error] string value is redundantly quoted with any quotes (quoted-strings)
> ./Documentation/devicetree/bindings/ufs/ufs-common.yaml:91:36: [error] string value is redundantly quoted with any quotes (quoted-strings)
> 

Oops! I ran the check on wrong binding file :/ Will fix it in next version.

- Mani

> dtschema/dtc warnings/errors:
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231003111232.42663-2-manivannan.sadhasivam@linaro.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

-- 
மணிவண்ணன் சதாசிவம்
