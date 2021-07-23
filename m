Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9023D40F0
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jul 2021 21:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhGWS4y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jul 2021 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhGWS4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jul 2021 14:56:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545DC061575;
        Fri, 23 Jul 2021 12:37:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n10so4351943plf.4;
        Fri, 23 Jul 2021 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ug84KscOa14uJZjGWmJauocgYTbuf32JtBk89q5M9Ec=;
        b=gylZR105FXVs3cpAscdhUGADFf4ivBWv17GiDnG66Asn4r8NxNw0vqi3KmTGk9+ZC0
         UBL+eP0v0XkCGL5W/dlW0Y0JswASMD/1IdYmEQ9kKaclq+Vesn0RwPpdXf029aDCgZJY
         uglH46JmzRH8A/uDpoTugIx7U+Pwlj0i6XW4rfrn7hDNku7WmQ6mCvxaHQR7IEZOmsNB
         ZKSXMlfVeTi0udujPopj6vLkf1zTcQUoFs2tcsfQ+TBRws+qD76NAoq9cCkEwytRoPek
         ogDG++BNwwXLPnBF4dlmfIOIplWl0+vZVRWbeUic67R8CGYz+4nb/HLZm8f8oBW4Wj5c
         5tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ug84KscOa14uJZjGWmJauocgYTbuf32JtBk89q5M9Ec=;
        b=H0kggkSxWBKjEZ+nwhzJgLhSKvgN83bvXmyRjW+i0EC10HBxdPDPQNeoXd4IEwRgOO
         4ZNE+0ZeyBVqBqMCS4CGdcCxslcalMvmd6uCWccW44OfSXnZOXF38tk2Ss+9QjoWx5wv
         29IuLeRFzSZBdu/3OGMBK4RfR7czjM2lfo9JLqI2kuqm1AJ2dZSIZqwVx6z9Rm71J4Dd
         Y47ypr2o7V05hSh6auIZ6ZqwXgRHhwn50IFp76Ze0D/inCwEmsQ3jrNFkZTn5C9ffBsK
         6jbOY6LuCklBrnZzWx+XAiDfTtBggDd+frKYUYIjRG/alrvzJhIBAadYHS4ZLxnXVcyQ
         y1Rw==
X-Gm-Message-State: AOAM533gtWAbeJiL9aSuixYh95mr0CAP2QRs2UB2Fkv9XW5siwStAkXI
        bqfzElErz3t2NJQPL1bgLmQ=
X-Google-Smtp-Source: ABdhPJxdFKPadstrPD/XwFATIPXHut2wfNW8Qs7toj4SFcyo+yEwLIKJq2OAf7dU8ddfnqH4ScgxTQ==
X-Received: by 2002:a17:903:2307:b029:12b:9349:22d7 with SMTP id d7-20020a1709032307b029012b934922d7mr4897888plh.9.1627069045363;
        Fri, 23 Jul 2021 12:37:25 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:55b1:90d5:6a79:755f])
        by smtp.gmail.com with ESMTPSA id a23sm35508591pfn.117.2021.07.23.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:37:24 -0700 (PDT)
Date:   Fri, 23 Jul 2021 12:37:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     satya priya <skakit@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH V4 4/5] dt-bindings: input: pm8941-pwrkey: Convert pm8941
 power key binding to yaml
Message-ID: <YPsacSlizlaiXgkp@google.com>
References: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
 <1620800053-26405-5-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620800053-26405-5-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 12, 2021 at 11:44:12AM +0530, satya priya wrote:
> Convert qcom pm8941 power key binding from .txt to .yaml format.
> 
> The example has been removed in favour of full example being
> available in the qcom,pon.yaml binding.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

Applied, thank you.

-- 
Dmitry
