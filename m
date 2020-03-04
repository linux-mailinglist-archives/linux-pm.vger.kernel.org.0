Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AECA1792B7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 15:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCDOsn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 09:48:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41288 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDOsn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 09:48:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so2305091oie.8;
        Wed, 04 Mar 2020 06:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z37RDKjhEWMZSq2IhaCi4CVQ02Trmh74iEkByVgA+JY=;
        b=SkAR3gsZ07x+4Nr45tU/Ge/ZTxM670cdDxeQe6n7Cq7HzlNltBEL7P+JeGDdBpPW7C
         U3N3Q1aXEYE8eXW7okmaI7edv1jIUMEQ/FmW/QoPrvSH+YNeVrQgnMgdVnl/s9YyoBSQ
         s/aHvuJI+/PnsezRX/QPIWo4xNVS3TDoQFRZYOKww1CpYeWcqU6h6lC4yak1WCQPjX+Q
         EHXgiz5szTaatg6IL6wIk+PuHGSGnb5XvtAilqdtiuqkBwUcBuizeG+88JHeMTOqTyh/
         zlom3L9zsUv9mFfyK8Z4Xx9kUcozPoDJGHmYcl/gUxxr1fvxGE3jHbvZSmrXuCy5Gpxy
         YwBQ==
X-Gm-Message-State: ANhLgQ2miBXDDLzynLUZ+B/i2ZSaJFro8Ms0OcjPP1TQCYHERV1LIGOO
        dJAP/ReBa4axZcUYqPX8S+m14k4=
X-Google-Smtp-Source: ADFU+vvpQjhrkfTrnQQhYZPi7wn7HSQ5jd9hBcoxYDvpS95Cayk9pvrQFVpg4nkd2kF3jAzlCRop0w==
X-Received: by 2002:a05:6808:d7:: with SMTP id t23mr1997527oic.69.1583333322201;
        Wed, 04 Mar 2020 06:48:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g17sm7006076otg.55.2020.03.04.06.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:48:40 -0800 (PST)
Received: (nullmailer pid 325 invoked by uid 1000);
        Wed, 04 Mar 2020 14:48:40 -0000
Date:   Wed, 4 Mar 2020 08:48:39 -0600
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
Subject: Re: [PATCH 3/7] dt-bindings: power: Convert domain-idle-states
 bindings to json-schema
Message-ID: <20200304144839.GA32730@bogus>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303150749.30566-4-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue,  3 Mar 2020 16:07:45 +0100, Ulf Hansson wrote:
> While converting to the json-schema, let's also take the opportunity to
> further specify/clarify some more details about the DT binding.
> 
> For example, let's define the label where to put the states nodes, set a
> pattern for nodename of the state nodes and finally add an example.
> 
> Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  .../devicetree/bindings/arm/psci.yaml         |  2 +-
>  .../bindings/power/domain-idle-state.txt      | 33 ---------
>  .../bindings/power/domain-idle-state.yaml     | 67 +++++++++++++++++++
>  .../bindings/power/power-domain.yaml          | 22 +++---
>  .../bindings/power/power_domain.txt           |  2 +-
>  5 files changed, 79 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt
>  create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.yaml
> 

Applied, thanks.

Rob
