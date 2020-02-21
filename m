Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A210616878B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 20:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBUTkQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 14:40:16 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:39748 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgBUTkQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 14:40:16 -0500
Received: by mail-pg1-f172.google.com with SMTP id j15so1491466pgm.6
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 11:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=727EAsMQRz3BzcKFq+yjaGZ0smZaJ6wq5lYL4hCxQBw=;
        b=eCmldwwmaGs6a9choQrTabZ5muMpoPYd8pgAxRa2sPm9ihylVfr8YYvavuA8os4vI5
         lJ3Yvnf196RWlWv5F8A28esZrv737PYuvntY+Ld1Yk/K50DesbseV60ri7BfqTQ93LsS
         y9j6cc4e3NrOsQ3mCtn3QVwYGVV07mts18kio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=727EAsMQRz3BzcKFq+yjaGZ0smZaJ6wq5lYL4hCxQBw=;
        b=F5Ocknl6QrhAyw5kQ2G7zhzh4OO09drgw4ZGnNFLSj8x6WXLvV6oWuGAs1H47uF5gb
         w8QIeZfwIkbysTOYuunmpCVZRKhii3JJSA0RlhERfDw24VDFeZJlJFJuCXlPpVmVmxB+
         aYDBpbDW3mGENrj2kaJrrmUvcHPCOji/oo/Q9GezjPoRGxDWlK3KznrvtU8pLrmE5Z34
         8w8D5zHTqdSRA4ntiskRPmqG74u1+zLN3xTBf45fSDV/kZMDong5CCA/SrFADEn1R3Fr
         z4ndYwVCeM2n5VDjuVzcMcbSTdjUxi/Kg7fllGQQZscILM4h3srjV3zpBNTdpaGDVCQq
         MHyg==
X-Gm-Message-State: APjAAAVq1wB7pQ0xR3Sd0YVZ1z+yboJOBkkqI6E0bsIq+3CyEdMlpHEL
        LUmArte6am0/VkY2aCb7nHCK2w==
X-Google-Smtp-Source: APXvYqzbFTpLuLBYG3azYe9VcGVTO7fozeU4ULbuEPbtS0mD0Bzq7RD4RTc+o/ZXgvYmXYycUD12+w==
X-Received: by 2002:aa7:8699:: with SMTP id d25mr38752067pfo.139.1582314014078;
        Fri, 21 Feb 2020 11:40:14 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id q8sm3289342pgt.57.2020.02.21.11.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 11:40:13 -0800 (PST)
Date:   Fri, 21 Feb 2020 11:40:12 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V3, 3/3] dt-bindings: interconnect: Add Qualcomm SC7180 DT
 bindings
Message-ID: <20200221194012.GF24720@google.com>
References: <1582277450-27382-1-git-send-email-okukatla@codeaurora.org>
 <1582277450-27382-4-git-send-email-okukatla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1582277450-27382-4-git-send-email-okukatla@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Odelu,

> Subject: dt-bindings: interconnect: Add Qualcomm SC7180 DT bindings

This patch doesn't add a binding, but DT entries for SC7180.

The subject of v2 was "arm64: dts: sc7180: Add interconnect provider
DT nodes", please go back to that or something similar.
