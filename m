Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7250D21F81C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgGNRXH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 13:23:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43014 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNRXG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 13:23:06 -0400
Received: by mail-io1-f67.google.com with SMTP id k23so18085316iom.10;
        Tue, 14 Jul 2020 10:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a+Jl/zD2Kd4gMYtf/Wpk6PVLO9f2VWE4h2cSc58BGeM=;
        b=ax2EXax7q8Y/HYPuOczNLhSrTZfjoSKXbY8uwAkdiywf6KstC6stOgvOFugS/82q0Z
         fKsPDG/f0JG6R57cQ/CYoZPN7vffOwULTTUN+8ZSh30Hx/cddojcwEsmrpNs4XPrm1Kq
         7sUx5lq2fVoZPb1QMMbt8kuNewDuOnEPqSvKqQarwlL3od9EssdhhWldxaUox1lDfXSX
         dNkR6/T2n5yZ0sQdRkrLZxoP0ddsAXkBrvewDFCV0vf391kXdK2td8NNlr8zSiA3Cp+C
         0/bZP4QXqKIjt+rS8TLftjglqFdR7bu/EYXh8zb5789tJdQZkjevLJ169aC9dZtON7Zy
         AXeg==
X-Gm-Message-State: AOAM530i8HlEPfW9L4O6CTiUE+Hzjp1duy2axYppK0VO2k0POg7Irm81
        IgWgmpDlAXelVK+mM1K32Q==
X-Google-Smtp-Source: ABdhPJzeFK+zSdeFlJs+zJIwYJ2Y28Ic1p/2Pg5cd6kDpy3hOI4vNjuhyszcgAI1tjSCWUERnvuBYA==
X-Received: by 2002:a5d:9503:: with SMTP id d3mr6027758iom.154.1594747383402;
        Tue, 14 Jul 2020 10:23:03 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g8sm10154384ilq.49.2020.07.14.10.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 10:23:02 -0700 (PDT)
Received: (nullmailer pid 2563893 invoked by uid 1000);
        Tue, 14 Jul 2020 17:23:01 -0000
Date:   Tue, 14 Jul 2020 11:23:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: interconnect: single yaml file for
 RPMh interconnect drivers
Message-ID: <20200714172301.GA2562995@bogus>
References: <20200713154121.22094-1-jonathan@marek.ca>
 <20200713154121.22094-2-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713154121.22094-2-jonathan@marek.ca>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 13 Jul 2020 11:41:10 -0400, Jonathan Marek wrote:
> These two bindings are almost identical, so combine them into one. This
> will make it easier to add the sm8150 and sm8250 interconnect bindings.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  .../{qcom,sc7180.yaml => qcom,rpmh.yaml}      | 33 ++++++++-
>  .../bindings/interconnect/qcom,sdm845.yaml    | 74 -------------------
>  2 files changed, 30 insertions(+), 77 deletions(-)
>  rename Documentation/devicetree/bindings/interconnect/{qcom,sc7180.yaml => qcom,rpmh.yaml} (67%)
>  delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:14:0: warning: "MASTER_SDCC_2" redefined
 #define MASTER_SDCC_2   3
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:14:0: note: this is the location of the previous definition
 #define MASTER_SDCC_2   2
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:17:0: warning: "SLAVE_A1NOC_SNOC" redefined
 #define SLAVE_A1NOC_SNOC   6
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:19:0: note: this is the location of the previous definition
 #define SLAVE_A1NOC_SNOC  7
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:18:0: warning: "SLAVE_SERVICE_A1NOC" redefined
 #define SLAVE_SERVICE_A1NOC   7
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:20:0: note: this is the location of the previous definition
 #define SLAVE_SERVICE_A1NOC  8
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:24:0: warning: "MASTER_CRYPTO" redefined
 #define MASTER_CRYPTO   4
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:26:0: note: this is the location of the previous definition
 #define MASTER_CRYPTO   3
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:25:0: warning: "MASTER_IPA" redefined
 #define MASTER_IPA   5
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:27:0: note: this is the location of the previous definition
 #define MASTER_IPA   4
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:27:0: warning: "SLAVE_A2NOC_SNOC" redefined
 #define SLAVE_A2NOC_SNOC   7
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:32:0: note: this is the location of the previous definition
 #define SLAVE_A2NOC_SNOC  9
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:28:0: warning: "SLAVE_SERVICE_A2NOC" redefined
 #define SLAVE_SERVICE_A2NOC   8
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:34:0: note: this is the location of the previous definition
 #define SLAVE_SERVICE_A2NOC  11
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:30:0: warning: "MASTER_CAMNOC_HF0_UNCOMP" redefined
 #define MASTER_CAMNOC_HF0_UNCOMP   0
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:123:0: note: this is the location of the previous definition
 #define MASTER_CAMNOC_HF0_UNCOMP 13
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:31:0: warning: "MASTER_CAMNOC_HF1_UNCOMP" redefined
 #define MASTER_CAMNOC_HF1_UNCOMP   1
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:124:0: note: this is the location of the previous definition
 #define MASTER_CAMNOC_HF1_UNCOMP 14
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:32:0: warning: "MASTER_CAMNOC_SF_UNCOMP" redefined
 #define MASTER_CAMNOC_SF_UNCOMP   2
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:125:0: note: this is the location of the previous definition
 #define MASTER_CAMNOC_SF_UNCOMP  15
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:33:0: warning: "SLAVE_CAMNOC_UNCOMP" redefined
 #define SLAVE_CAMNOC_UNCOMP   3
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:126:0: note: this is the location of the previous definition
 #define SLAVE_CAMNOC_UNCOMP  16
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:39:0: warning: "MASTER_SNOC_CNOC" redefined
 #define MASTER_SNOC_CNOC   0
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:38:0: note: this is the location of the previous definition
 #define MASTER_SNOC_CNOC  2
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:40:0: warning: "MASTER_QDSS_DAP" redefined
 #define MASTER_QDSS_DAP   1
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:39:0: note: this is the location of the previous definition
 #define MASTER_QDSS_DAP   3
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:41:0: warning: "SLAVE_A1NOC_CFG" redefined
 #define SLAVE_A1NOC_CFG   2
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:40:0: note: this is the location of the previous definition
 #define SLAVE_A1NOC_CFG   4
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:42:0: warning: "SLAVE_A2NOC_CFG" redefined
 #define SLAVE_A2NOC_CFG   3
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:41:0: note: this is the location of the previous definition
 #define SLAVE_A2NOC_CFG   5
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:48:0: warning: "SLAVE_CAMERA_CFG" redefined
 #define SLAVE_CAMERA_CFG    9
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:44:0: note: this is the location of the previous definition
 #define SLAVE_CAMERA_CFG  8
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:51:0: warning: "SLAVE_CLK_CTL" redefined
 #define SLAVE_CLK_CTL   12
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:45:0: note: this is the location of the previous definition
 #define SLAVE_CLK_CTL   9
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:52:0: warning: "SLAVE_RBCPR_CX_CFG" redefined
 #define SLAVE_RBCPR_CX_CFG   13
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:47:0: note: this is the location of the previous definition
 #define SLAVE_RBCPR_CX_CFG  11
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:54:0: warning: "SLAVE_CRYPTO_0_CFG" redefined
 #define SLAVE_CRYPTO_0_CFG   15
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:48:0: note: this is the location of the previous definition
 #define SLAVE_CRYPTO_0_CFG  12
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:55:0: warning: "SLAVE_DCC_CFG" redefined
 #define SLAVE_DCC_CFG   16
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:49:0: note: this is the location of the previous definition
 #define SLAVE_DCC_CFG   13
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:56:0: warning: "SLAVE_CNOC_DDRSS" redefined
 #define SLAVE_CNOC_DDRSS   17
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:50:0: note: this is the location of the previous definition
 #define SLAVE_CNOC_DDRSS  14
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:57:0: warning: "SLAVE_DISPLAY_CFG" redefined
 #define SLAVE_DISPLAY_CFG   18
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:51:0: note: this is the location of the previous definition
 #define SLAVE_DISPLAY_CFG  15
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:61:0: warning: "SLAVE_GLM" redefined
 #define SLAVE_GLM     22
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:52:0: note: this is the location of the previous definition
 #define SLAVE_GLM   16
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:62:0: warning: "SLAVE_GFX3D_CFG" redefined
 #define SLAVE_GFX3D_CFG   23
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:53:0: note: this is the location of the previous definition
 #define SLAVE_GFX3D_CFG   17
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:63:0: warning: "SLAVE_IMEM_CFG" redefined
 #define SLAVE_IMEM_CFG   24
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:54:0: note: this is the location of the previous definition
 #define SLAVE_IMEM_CFG   18
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:64:0: warning: "SLAVE_IPA_CFG" redefined
 #define SLAVE_IPA_CFG   25
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:55:0: note: this is the location of the previous definition
 #define SLAVE_IPA_CFG   19
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:65:0: warning: "SLAVE_CNOC_MNOC_CFG" redefined
 #define SLAVE_CNOC_MNOC_CFG   26
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:56:0: note: this is the location of the previous definition
 #define SLAVE_CNOC_MNOC_CFG  20
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:70:0: warning: "SLAVE_PDM" redefined
 #define SLAVE_PDM   31
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:59:0: note: this is the location of the previous definition
 #define SLAVE_PDM   23
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:71:0: warning: "SLAVE_PIMEM_CFG" redefined
 #define SLAVE_PIMEM_CFG   32
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:61:0: note: this is the location of the previous definition
 #define SLAVE_PIMEM_CFG   25
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:72:0: warning: "SLAVE_PRNG" redefined
 #define SLAVE_PRNG   33
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:62:0: note: this is the location of the previous definition
 #define SLAVE_PRNG   26
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:73:0: warning: "SLAVE_QDSS_CFG" redefined
 #define SLAVE_QDSS_CFG   34
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:63:0: note: this is the location of the previous definition
 #define SLAVE_QDSS_CFG   27
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:79:0: warning: "SLAVE_SDCC_2" redefined
 #define SLAVE_SDCC_2   40
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:66:0: note: this is the location of the previous definition
 #define SLAVE_SDCC_2   30
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:81:0: warning: "SLAVE_SNOC_CFG" redefined
 #define SLAVE_SNOC_CFG   42
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:68:0: note: this is the location of the previous definition
 #define SLAVE_SNOC_CFG   32
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:82:0: warning: "SLAVE_TCSR" redefined
 #define SLAVE_TCSR   43
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:71:0: note: this is the location of the previous definition
 #define SLAVE_TCSR   35
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:84:0: warning: "SLAVE_TLMM_NORTH" redefined
 #define SLAVE_TLMM_NORTH   45
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:72:0: note: this is the location of the previous definition
 #define SLAVE_TLMM_NORTH  36
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:85:0: warning: "SLAVE_TLMM_SOUTH" redefined
 #define SLAVE_TLMM_SOUTH   46
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:73:0: note: this is the location of the previous definition
 #define SLAVE_TLMM_SOUTH  37
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:86:0: warning: "SLAVE_UFS_MEM_CFG" redefined
 #define SLAVE_UFS_MEM_CFG   47
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:76:0: note: this is the location of the previous definition
 #define SLAVE_UFS_MEM_CFG  40
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:88:0: warning: "SLAVE_VENUS_CFG" redefined
 #define SLAVE_VENUS_CFG   49
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:79:0: note: this is the location of the previous definition
 #define SLAVE_VENUS_CFG   43
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:90:0: warning: "SLAVE_VSENSE_CTRL_CFG" redefined
 #define SLAVE_VSENSE_CTRL_CFG   51
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:80:0: note: this is the location of the previous definition
 #define SLAVE_VSENSE_CTRL_CFG  44
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:91:0: warning: "SLAVE_SERVICE_CNOC" redefined
 #define SLAVE_SERVICE_CNOC   52
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:82:0: note: this is the location of the previous definition
 #define SLAVE_SERVICE_CNOC  46
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:95:0: warning: "SLAVE_LLCC_CFG" redefined
 #define SLAVE_LLCC_CFG   2
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:85:0: note: this is the location of the previous definition
 #define SLAVE_LLCC_CFG   1
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:101:0: warning: "MASTER_MNOC_HF_MEM_NOC" redefined
 #define MASTER_MNOC_HF_MEM_NOC   4
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:97:0: note: this is the location of the previous definition
 #define MASTER_MNOC_HF_MEM_NOC  3
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:102:0: warning: "MASTER_MNOC_SF_MEM_NOC" redefined
 #define MASTER_MNOC_SF_MEM_NOC   5
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:98:0: note: this is the location of the previous definition
 #define MASTER_MNOC_SF_MEM_NOC  4
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:103:0: warning: "MASTER_SNOC_GC_MEM_NOC" redefined
 #define MASTER_SNOC_GC_MEM_NOC   6
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:99:0: note: this is the location of the previous definition
 #define MASTER_SNOC_GC_MEM_NOC  5
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:104:0: warning: "MASTER_SNOC_SF_MEM_NOC" redefined
 #define MASTER_SNOC_SF_MEM_NOC   7
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:100:0: note: this is the location of the previous definition
 #define MASTER_SNOC_SF_MEM_NOC  6
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:105:0: warning: "MASTER_GFX3D" redefined
 #define MASTER_GFX3D   8
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:101:0: note: this is the location of the previous definition
 #define MASTER_GFX3D   7
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:106:0: warning: "SLAVE_MSS_PROC_MS_MPU_CFG" redefined
 #define SLAVE_MSS_PROC_MS_MPU_CFG   9
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:102:0: note: this is the location of the previous definition
 #define SLAVE_MSS_PROC_MS_MPU_CFG 8
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:108:0: warning: "SLAVE_LLCC" redefined
 #define SLAVE_LLCC   11
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:104:0: note: this is the location of the previous definition
 #define SLAVE_LLCC   10
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:114:0: warning: "MASTER_LLCC" redefined
 #define MASTER_LLCC   0
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:107:0: note: this is the location of the previous definition
 #define MASTER_LLCC   13
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:115:0: warning: "SLAVE_EBI1" redefined
 #define SLAVE_EBI1   1
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:108:0: note: this is the location of the previous definition
 #define SLAVE_EBI1   14
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:122:0: warning: "MASTER_ROTATOR" redefined
 #define MASTER_ROTATOR   5
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:116:0: note: this is the location of the previous definition
 #define MASTER_ROTATOR   6
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:123:0: warning: "MASTER_VIDEO_P0" redefined
 #define MASTER_VIDEO_P0   6
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:117:0: note: this is the location of the previous definition
 #define MASTER_VIDEO_P0   7
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:124:0: warning: "MASTER_VIDEO_PROC" redefined
 #define MASTER_VIDEO_PROC   7
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:119:0: note: this is the location of the previous definition
 #define MASTER_VIDEO_PROC  9
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:125:0: warning: "SLAVE_MNOC_HF_MEM_NOC" redefined
 #define SLAVE_MNOC_HF_MEM_NOC   8
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:121:0: note: this is the location of the previous definition
 #define SLAVE_MNOC_HF_MEM_NOC  11
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:126:0: warning: "SLAVE_MNOC_SF_MEM_NOC" redefined
 #define SLAVE_MNOC_SF_MEM_NOC   9
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:120:0: note: this is the location of the previous definition
 #define SLAVE_MNOC_SF_MEM_NOC  10
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:127:0: warning: "SLAVE_SERVICE_MNOC" redefined
 #define SLAVE_SERVICE_MNOC   10
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:122:0: note: this is the location of the previous definition
 #define SLAVE_SERVICE_MNOC  12
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:150:0: warning: "MASTER_PIMEM" redefined
 #define MASTER_PIMEM   4
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:134:0: note: this is the location of the previous definition
 #define MASTER_PIMEM   6
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:151:0: warning: "SLAVE_APPSS" redefined
 #define SLAVE_APPSS   5
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:136:0: note: this is the location of the previous definition
 #define SLAVE_APPSS   8
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:152:0: warning: "SLAVE_SNOC_CNOC" redefined
 #define SLAVE_SNOC_CNOC   6
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:137:0: note: this is the location of the previous definition
 #define SLAVE_SNOC_CNOC   9
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:155:0: warning: "SLAVE_IMEM" redefined
 #define SLAVE_IMEM   9
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:140:0: note: this is the location of the previous definition
 #define SLAVE_IMEM   12
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:156:0: warning: "SLAVE_PIMEM" redefined
 #define SLAVE_PIMEM   10
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:143:0: note: this is the location of the previous definition
 #define SLAVE_PIMEM   15
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:157:0: warning: "SLAVE_SERVICE_SNOC" redefined
 #define SLAVE_SERVICE_SNOC   11
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:144:0: note: this is the location of the previous definition
 #define SLAVE_SERVICE_SNOC  16
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:158:0: warning: "SLAVE_QDSS_STM" redefined
 #define SLAVE_QDSS_STM   12
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:145:0: note: this is the location of the previous definition
 #define SLAVE_QDSS_STM   17
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:53:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sc7180.h:159:0: warning: "SLAVE_TCU" redefined
 #define SLAVE_TCU   13
 
In file included from Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:19:0:
./scripts/dtc/include-prefixes/dt-bindings/interconnect/qcom,sdm845.h:146:0: note: this is the location of the previous definition
 #define SLAVE_TCU   18
 
Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dts:69.40-74.11: ERROR (duplicate_label): /example-1/interconnect@1740000: Duplicate label 'mmss_noc' on /example-1/interconnect@1740000 and /example-0/interconnect@1740000
ERROR: Input tree has errors, aborting (use -f to force output)
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/interconnect/qcom,rpmh.example.dt.yaml] Error 2
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1328116

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

