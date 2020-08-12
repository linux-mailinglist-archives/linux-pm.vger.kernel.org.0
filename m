Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C2242D1E
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgHLQ0J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 12:26:09 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42477 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgHLQ0I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 12:26:08 -0400
Received: by mail-il1-f194.google.com with SMTP id t13so2312102ile.9;
        Wed, 12 Aug 2020 09:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xT4SACgf5ifSMoS9uK+2nXefsvRA+9v+8cofR3WoWzc=;
        b=eFCSk9QX9TN5MGrgx57WS82IdgYflcoYhf7Je0a5lwTSg1Vq+MruTthtwWnAPtxZK7
         fhn15DR0ksxIE0v5E+AEc6IZ89/V0iRHC4gpr8/tUyBTqZ4OAF8wM8C/ENocDzyRArZi
         bXPXbi/dziJoKAC8if+h99fEIJGh6xasMu0P2tJNt2MPse6ijAey4+UowIra+pUJ1+fx
         Owfvs85ML0PwO13lbuxH7Laqn7lvi/LGuXndYM6j3P7NZnyRQfnhs8rqPXKo82mvNRyS
         JD4J7jCEs+VS3eExi9y+Kv49rIVgZ16zDiRqie/fHGxrXTOj3qHPc+Hw3lP+X9kYqOu8
         BvRA==
X-Gm-Message-State: AOAM530EslWbVj3WXu35bk6R4zm/Wpo4gxY5u3F29ZWW7WCO4grD3stu
        9E/NpMYTH9Guu5VVRjRhHQ==
X-Google-Smtp-Source: ABdhPJxhvNiEn01QPTStOSaoRMJBQMRWM+MEiL+Bc4h8Pvco/4kQQxQ01omTeuR5kwXN7ubmYfG9+w==
X-Received: by 2002:a92:5b1c:: with SMTP id p28mr452119ilb.133.1597249567760;
        Wed, 12 Aug 2020 09:26:07 -0700 (PDT)
Received: from xps15 ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k18sm1185733ioh.50.2020.08.12.09.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:26:06 -0700 (PDT)
Received: (nullmailer pid 2319809 invoked by uid 1000);
        Wed, 12 Aug 2020 16:26:04 -0000
Date:   Wed, 12 Aug 2020 10:26:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-mediatek@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        wsd_upstream@mediatek.com, Li Yang <leoyang.li@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 2/2] dt-bindings: cpufreq: add  MediaTek cpufreq
 bindings
Message-ID: <20200812162604.GA2319433@bogus>
References: <1596716320-19811-1-git-send-email-hector.yuan@mediatek.com>
 <1596716320-19811-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596716320-19811-3-git-send-email-hector.yuan@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 06 Aug 2020 20:18:40 +0800, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree bindings for MediaTek HW driver.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |   56 ++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.example.dt.yaml: example-0: cpufreq@11bc00:reg:0: [0, 1162256, 0, 140] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.example.dt.yaml: example-0: cpufreq@11bc00:reg:1: [0, 1162400, 0, 140] is too long


See https://patchwork.ozlabs.org/patch/1341854

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

