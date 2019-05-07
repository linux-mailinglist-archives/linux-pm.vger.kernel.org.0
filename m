Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42FA16879
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEGQ5F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 12:57:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34351 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfEGQ5F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 12:57:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id l17so6093665otq.1;
        Tue, 07 May 2019 09:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6RHMQB9VsKEtQqS8G9mnViUVuGlcHIfclZdgk/wbUV8=;
        b=ZK8Nnu8GY66LDCSZq9QHAPh4hsCklQ8xzNMP2br18SU511tv/5Ar3EDHFMBbNj4q84
         H/HXBJKPmqr3eSIlQVR2C7CAMtR3Ji1kj83o84EB0EI+sE9MPy+RpLIEmzYAjy+Bkr7F
         nzztk84LEqvq6mQ3va1itB0Sgia+gH833y+H6YlAdYSnQymQrQXEgjXQ3C2mhT3+nr2H
         8r7Bf2f4iFdxvedbrhnuggX0AaOffjPewdvx6ULHYk7IqN1XHbE4iJbFzuVdSs2oIGC6
         Px3OTIz+X9dw9xKvqMLypw4itkcwDi3dEMSOBje4iLdsm/x1al2vDXZdR0u2Ccc392zo
         ZwrA==
X-Gm-Message-State: APjAAAXDu4i8RLtNo1FNwlU4Qacm5/0G+zT+xtdPQP2zayHD45lNylUM
        K5hkXtiHHpQQFD2h+yjy5asR74M=
X-Google-Smtp-Source: APXvYqzu8AIp7fFUsfN2rUa5cBm1eaPc1YwsapNxl5TxnL6Ff2he9kIUwK3dNY/DU/9pQHKCc0s8Gg==
X-Received: by 2002:a05:6830:1510:: with SMTP id k16mr6166230otp.226.1557248224453;
        Tue, 07 May 2019 09:57:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g21sm2591156otj.25.2019.05.07.09.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 09:57:03 -0700 (PDT)
Date:   Tue, 7 May 2019 11:57:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v7 04/13] dt-bindings: ddr: rename lpddr2 directory
Message-ID: <20190507165703.GA20137@bogus>
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190506151213eucas1p2ca40029d09ddbbcd11e4a1dd60ae9654@eucas1p2.samsung.com>
 <1557155521-30949-5-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557155521-30949-5-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon,  6 May 2019 17:11:52 +0200, Lukasz Luba wrote:
> Change directory name to be ready for new types of memories.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/ddr/lpddr2-timings.txt     |  52 +++++++++++
>  Documentation/devicetree/bindings/ddr/lpddr2.txt   | 102 +++++++++++++++++++++
>  .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |  52 -----------
>  .../devicetree/bindings/lpddr2/lpddr2.txt          | 102 ---------------------
>  4 files changed, 154 insertions(+), 154 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
>  create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2.txt
>  delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
>  delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
