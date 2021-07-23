Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570773D40F5
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jul 2021 21:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhGWS5G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jul 2021 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhGWS5E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jul 2021 14:57:04 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D51C061575;
        Fri, 23 Jul 2021 12:37:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i1so4226646plr.9;
        Fri, 23 Jul 2021 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yoiuJ10839QAwyA+NrQNXhkBdSscUG9PDJI9vnVPsp4=;
        b=Vwrpl1twUtZ9NdGwKbmB16DCbnQ4hYin29l7/9tG2rrnWaYAxcJyhHBaYh0iadu+3A
         OfxUZ1JbA9mWUvpN3jaFwDrDAJbm7cFxRqRcCgGC1+o5bEG+Lo3zeHiiNNzQSss9dtYA
         5auIDYKr+XN9RrBPx9IO/4PhCGSibLOJagRU0uNlJfLW+D1fsvYPzWGind5vTGCRzpHD
         YJP1UcVl1xAnoOeiXs9f6dIRtBYIQ+DiI1Y3OGsD3xpKwwi2tvGfzEuaw8IzKSMWhL0i
         VYKfpPpJEkXWIFgXZuxiv55WYSseN6JDSv//4Vrv+CT4sa9MeVIIjeMpMW9M0xaONB+W
         SvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yoiuJ10839QAwyA+NrQNXhkBdSscUG9PDJI9vnVPsp4=;
        b=sP/6c1Ws0Lp+pW6+fSm3w2oeeWeGt8797jOBZVdL+KYmzLD6x9Tcxw7VTlO4IMBCRP
         p2L8KfZcC8wssv1iKGziegBa2adbXhmGVIAZbxEZoyouJpOYrXVoGiSrW1jXgtzQ3Zh/
         OCyxRwSxxu8JRJsyybH7e9qZUkyaU9aL1VPnNP4TOuvFLa35GH+rv/VlVtgCmf43dN+2
         +tmC1dkdqdO2boy8234vjBoXRp3kKs6QXsnHojD5Lefy1NkUGqBqMihuqce0HR6FfgPm
         wi/lc5pcoiRP6v2VR4Rh9IxmjfeaGXcI5C9wfiFUh2lzBjKUlolnmJaxHpPZQApiIp4F
         a7hg==
X-Gm-Message-State: AOAM530gUD620SUa4o1l8H7SUs0pJYlh7T8wRzaB2tRXU0nzDDHi7kWD
        o2cBpM1dCwCo1pxzYgijk5w=
X-Google-Smtp-Source: ABdhPJyST6URR4hKHGDDnx0z2ErsRTTyWIy/wAFQo8DR1sORxUHheEjfyU/A/G7hOZuug6NIgwyW+g==
X-Received: by 2002:a17:902:c64b:b029:12b:25f7:9b17 with SMTP id s11-20020a170902c64bb029012b25f79b17mr4947650pls.24.1627069056754;
        Fri, 23 Jul 2021 12:37:36 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:55b1:90d5:6a79:755f])
        by smtp.gmail.com with ESMTPSA id t205sm7967494pfc.32.2021.07.23.12.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:37:36 -0700 (PDT)
Date:   Fri, 23 Jul 2021 12:37:33 -0700
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
Subject: Re: [PATCH V4 5/5] dt-bindings: power: reset: qcom-pon: Convert qcom
 PON binding to yaml
Message-ID: <YPsafb7QBeV+Om3M@google.com>
References: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
 <1620800053-26405-6-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620800053-26405-6-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 12, 2021 at 11:44:13AM +0530, satya priya wrote:
> Convert qcom PON binding from .txt to .yaml format.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
