Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F100219474B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 20:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZTPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 15:15:50 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46981 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTPu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 15:15:50 -0400
Received: by mail-il1-f196.google.com with SMTP id e8so6467273ilc.13;
        Thu, 26 Mar 2020 12:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Olt13sdtE0D4LAs797wG3erKxjKOvDid+wOGLdWtI/Q=;
        b=EcH46TOfrUdkt6EPYEQ3QQQQUyJEOp65u1N7TmQooqSBnk10yLme+BGud+Naf1NK57
         QAISnLxmMk0qxw/vfcheZ7IZch1IKkexNjUuqUSTnQ2LPemCrLpNw/SXRB5oaC4R3oBJ
         ugq2Xq0DPglEju+32dYPFCglNH09hznvxF/DQtXaM1RMHZbuMQbsG7CO+Lz3uywNFKMZ
         G2HNtLSR41mJJ6lO/KqSZvyibEP2azX51Qcm3hyB20kyy3WCSCsOVF6k9v2Y1rAs0jbo
         uKKArPc8I8ECLO/QaqudES7m8V2eDpntHCJHaC0n2dmFrXfCrgoi6LRwfArUcj1HBipg
         qCgw==
X-Gm-Message-State: ANhLgQ2MtVOb7nC0nGSMfLTRdgdVOKRziPdAhhYwHc9NSJ6Ie6r1/z8a
        a0MZMCd1jxFPXbmsJQ/f82zg/Lk=
X-Google-Smtp-Source: ADFU+vt5XiMccSt51KtqStNQbL6xMBa8dlZTZsEXhIz9yvw00X/Uh9S7Hd3S//8uEYuiP17IMzmlNQ==
X-Received: by 2002:a92:dd0e:: with SMTP id n14mr10757476ilm.0.1585250149285;
        Thu, 26 Mar 2020 12:15:49 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s82sm1074423ili.87.2020.03.26.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:15:48 -0700 (PDT)
Received: (nullmailer pid 4026 invoked by uid 1000);
        Thu, 26 Mar 2020 19:15:47 -0000
Date:   Thu, 26 Mar 2020 13:15:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: Re: [PATCH v6 2/3] dt-bindings: power: supply: add cw2015_battery
 bindings
Message-ID: <20200326191547.GA3964@bogus>
References: <20200321125241.3072123-1-t.schramm@manjaro.org>
 <20200321125241.3072123-3-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321125241.3072123-3-t.schramm@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 21 Mar 2020 13:52:40 +0100, Tobias Schramm wrote:
> This patch adds the dts binding schema for the cw2015 fuel gauge.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../bindings/power/supply/cw2015_battery.yaml | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
