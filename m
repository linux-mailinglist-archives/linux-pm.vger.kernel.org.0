Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9EEEB16
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 22:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfKDV2q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 16:28:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44596 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfKDV2q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 16:28:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id s71so15518710oih.11;
        Mon, 04 Nov 2019 13:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9acXWsdEFrkPA1Lgl9MMn5B4FiSOAYHswfR+JTN/Dic=;
        b=i+azHwooPjktf+h/FiC2NVQc2v1Hs24+bXIDCnWUq7id+0x5nLpBfN+w8Vhdsmv+e4
         j55vIaISx7xIgn4carqCzHwRZFfmZG5HiG5mxpxInx5wiU2VM8r3ftMbZOW34vr1YKbP
         cN3LonrrI7sHDRDgz8PyejufT64qUfb9PsRnKWgDSujXUh7FYKjAXU+plb90BvL5I3Gg
         rkPnHmCC1j3ECus+5NRXKb/6EbXQKiRQsbPuxH8qEbGKBC5H0+YgOaNm3XkNo4pcXenj
         PmJ+nzo9+SOWNPfhnHV29VciUvm8WTpRZBa8fi1ve9G9oXbE/nf1OX0noqxPGAnLLAoj
         EgwA==
X-Gm-Message-State: APjAAAVRkUtDqCoAEznegmZpsa/aVEgJHqZ/hIFsZm0TJI2KaJEOzbHo
        8WkpHxoo/oIplo8JrLYF6A==
X-Google-Smtp-Source: APXvYqyaTn81E9AP4eQnyMQSgJxivr7c/dErrETeT11+u2IPdaQ5TAf8rw4iL5Ra03TJ+aegp2oFoQ==
X-Received: by 2002:aca:578e:: with SMTP id l136mr1009252oib.132.1572902925405;
        Mon, 04 Nov 2019 13:28:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m14sm5112256otl.26.2019.11.04.13.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 13:28:44 -0800 (PST)
Date:   Mon, 4 Nov 2019 15:28:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: Re: [PATCH v10 1/3] dt-bindings: interconnect: Add Qualcomm MSM8916
 DT bindings
Message-ID: <20191104212844.GA6884@bogus>
References: <20191030153904.8715-1-georgi.djakov@linaro.org>
 <20191030153904.8715-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030153904.8715-2-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 30 Oct 2019 17:39:02 +0200, Georgi Djakov wrote:
> The Qualcomm MSM8916 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom,msm8916.yaml   |  77 ++++++++++++++
>  .../dt-bindings/interconnect/qcom,msm8916.h   | 100 ++++++++++++++++++
>  2 files changed, 177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8916.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
