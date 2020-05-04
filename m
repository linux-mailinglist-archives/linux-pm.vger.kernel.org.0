Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6421C4763
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 21:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgEDTvp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 15:51:45 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:46063 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgEDTvp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 15:51:45 -0400
Received: by mail-oo1-f66.google.com with SMTP id 190so2675677ooa.12;
        Mon, 04 May 2020 12:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kTLGnv8cHLkJNeKGrYbsMBKwEzpFrwnlRZi0qh+VmkQ=;
        b=KecKXEucfCFOaEv3wPlZkdbVyPKFl/jPFIaI8choBtkFx9okFKLq4IOQpQ9KufO8Bk
         BK7xwD9rAEwtBzPizwKKWdtBv27ej1JNHh1J8JWKU+BdnkId8U8urIsKjkfZf4/iBm4R
         CB775FkFHiwoXI6sin+8cVXtKVKe1TnK10JxkIk5jkFJZp/9iGST+4RY2DAIOBhb1X8O
         u6RXkn4czw5p2AVWbMMuEDZxExcvL/HtJIV8EcosMX9KzhoznStAXZmKvfIU2BJyvVoY
         fn7k2ntP1+UdoKfWlGAR50isZ7Jho8J5LRAMeU6zYTTar4j2N1tlcl2jvIkOBlXLWspx
         XcFw==
X-Gm-Message-State: AGi0PuatpWmuqUkotJhEle7B6euBtSnT6u6+HSDWygR4MY3wp+CVG/rW
        DslEpogfNDzb87hync99ug==
X-Google-Smtp-Source: APiQypKWcNfegIl3LfRI5pjK/dZmUaCOvDV57LPNEZELGNO0eTGx2sUvOoW4yNeccsnAUCEfaJMqQw==
X-Received: by 2002:a4a:4442:: with SMTP id o63mr7868ooa.0.1588621904225;
        Mon, 04 May 2020 12:51:44 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 186sm3548725ooi.30.2020.05.04.12.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:51:43 -0700 (PDT)
Received: (nullmailer pid 15522 invoked by uid 1000);
        Mon, 04 May 2020 19:51:42 -0000
Date:   Mon, 4 May 2020 14:51:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Konrad Dybcio <konradybcio@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: tsens: qcom: Document MSM8939 compatible
Message-ID: <20200504195142.GA15440@bogus>
References: <20200501203311.143934-1-konradybcio@gmail.com>
 <20200501203311.143934-3-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501203311.143934-3-konradybcio@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri,  1 May 2020 22:33:11 +0200, Konrad Dybcio wrote:
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
