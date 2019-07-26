Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 674967604C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 10:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfGZIEV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 04:04:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32872 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfGZIEV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 04:04:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so15157793pgj.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 01:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RvwPhyEIP2C1GmNkk4CaBRsJ7LL1kgFaxYotbYvMHPg=;
        b=TYUJvMUexVnsX0m0MLXy24SyzzBqxoROwI7Uc7k8Jawjx30BNj/P3fgvOFd6mgF1ub
         gMVRPVNnGlbMn9NCKeeCRsnJEAJyRti2+XO2Cidy1kRVFPi37z0pc6C6sl6nml6arwGc
         Fe3IOu2AU/BEX1zbbAf3j+/uxFr2E2/wfJudYBKmpnOEyuAlRvQuWNkURmXId2PaGK3N
         iOGNsLw9G/mWislf38UtZ7PUMUIOQwb13WIAANRonntJ5JaszUsHIqMcn7tijUGIWr4e
         UQkx7dd5w0uacRGojJgwxU9+gJEApSPq6Xf8RPPY5kmnAtloZB6KcmHH+c7Iukhd46by
         zpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RvwPhyEIP2C1GmNkk4CaBRsJ7LL1kgFaxYotbYvMHPg=;
        b=VzJc9wfWQTLLVVDXyDzWCmdaAKDOg9hEf7mogQUgUXNhpKMzsUQZBvC6R7dEi+17fK
         YdOiUroWuOxlgthsKugyorSkOBsKlHEy0fS1Oq+5kMaXuVEqiSR7zmaH5awtIxln9vmV
         Rmh6pEPpb3TOPv7jDLkoFW1luChWERmOzW43k7o6qdbj2rkNcR8WkOcGMF743GSyupFC
         LUWE9vQHF+hF1FnW7gW1FVCOjKYz7rdRAe/5qdK01DVXWP6HmE9qVJZdfNvQAeyqUBOC
         Vujlk+n9D3A+uRfytPFuM3Qn5QXQZ9V+0ri9e/cOH2wmkvvsN0INnlSOTe5N69QgxRD4
         pTUQ==
X-Gm-Message-State: APjAAAWnUOilqLvKQTlulfsC8M+QXMEr6GpSTesJrOhAyVxwf9hSx8MS
        +9CoUcAkB5bV4f6FK/mA5p6m7w==
X-Google-Smtp-Source: APXvYqxTsDwHnJcVzgc3D4+iVqCkMgf3qQEn4QWbmVPCdg1WXTAvCSSDgDPosNz3oyuEWm6Zp3gYRw==
X-Received: by 2002:a63:d852:: with SMTP id k18mr18912708pgj.313.1564128260209;
        Fri, 26 Jul 2019 01:04:20 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id c12sm38958764pgb.83.2019.07.26.01.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 01:04:19 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:34:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Sricharan R <sricharan@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: cpufreq: Re-organise kryo cpufreq
 to use it for other nvmem based qcom socs
Message-ID: <20190726080417.ohsgedbtyxbxfyj7@vireshk-i7>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
 <20190725104144.22924-3-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725104144.22924-3-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

$subject of this and few more binding patches updated to:

"dt-bindings: opp: XXX"

On 25-07-19, 12:41, Niklas Cassel wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> The kryo cpufreq driver reads the nvmem cell and uses that data to
> populate the opps. There are other qcom cpufreq socs like krait which
> does similar thing. Except for the interpretation of the read data,
> rest of the driver is same for both the cases. So pull the common things
> out for reuse.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [niklas.cassel@linaro.org: split dt-binding into a separate patch and
> do not rename the compatible string.]
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Reviewed-by: Ilia Lin <ilia.lin@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since V1:
> -Picked up tags.

-- 
viresh
