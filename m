Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB631792B4
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCDOsA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 09:48:00 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40606 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDOsA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 09:48:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id j80so2312282oih.7;
        Wed, 04 Mar 2020 06:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kTVi0CY1WYThcNH0JrXSu81YjmvaHeU7QQq5m/gXIKM=;
        b=B6hP+COhtvWmPxY5gY9uEjoc2Fth0BawPEQFtfryYb2HIi4bxzujR244QERiuyLj8Y
         ZnwkLXMfouWvKMAc15h90DnAv1mGsqeGSg2D0JaEER2fIHVoJzlwLQ9ll2BrV+Fb8cr8
         VtSd0sgEXe9H41nRyVVGuvu4+Tx21uD0strfVeLlgqQ1hYD3ffZzsxnxnYwe8BQUfBRV
         NE3nnpt+5ItZn4nuPyQ4fyaVnLDarApyZ32njdR2vNFIO3ecUk0mEhi5IoiH/QNdrI3p
         zDkag23Yt8rABJAV4dlHXSO4gKBd1ewCiYucLpQ2BDU398QYaLGJR6ekR2R0//wEW5Aq
         Ow5Q==
X-Gm-Message-State: ANhLgQ2vETDzJk0rHgM7UQ48szznECF/UO1D5rPs/cvpI56inYyHXo/Q
        P1Mm3gLzne2aeI+czuJvAurKE8g=
X-Google-Smtp-Source: ADFU+vutJMPeQAk58XIyXq44RtRjch3aZjhj5tMH/gdNf7NpGZqGIc4M4+aVGrQmnTlsNKVWGrSmyA==
X-Received: by 2002:a54:4085:: with SMTP id i5mr1991775oii.17.1583333279432;
        Wed, 04 Mar 2020 06:47:59 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q1sm1200434oij.18.2020.03.04.06.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:47:58 -0800 (PST)
Received: (nullmailer pid 31673 invoked by uid 1000);
        Wed, 04 Mar 2020 14:47:57 -0000
Date:   Wed, 4 Mar 2020 08:47:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: arm: Fix cpu compatibles in the
 hierarchical example for PSCI
Message-ID: <20200304144757.GA31548@bogus>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303150749.30566-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue,  3 Mar 2020 16:07:44 +0100, Ulf Hansson wrote:
> Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
