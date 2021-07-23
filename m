Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6961A3D40EC
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jul 2021 21:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGWS4o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jul 2021 14:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWS4n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jul 2021 14:56:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97FDC061575;
        Fri, 23 Jul 2021 12:37:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j17-20020a17090aeb11b029017613554465so5128650pjz.4;
        Fri, 23 Jul 2021 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66xVPwdcfssjg8x3e8OZtHo+7glyERJG9zKbkn+ZIAA=;
        b=R00BZ36nLs5vy/beQpWTa/RtFsSL3UFcWWxfDijRX/HQ8LUL0YEdRbMB1KchxHMRhF
         J7sMqQ3EdlA0WNAw1RstFo/2WG0FM7lHSifGMuzVt+TqGqCCIvAJTZ79grbvkN36+jTP
         8U65pfb5nC70cp8rA0otCoDQ5VEP15V0UGeE6iF8CnPqlrWU+65ks8b8F2rfKg+Hh+mP
         /Zm0GklCd2LNjdmaN8WBQeRa0f4FY1/EaZohRHJZ1x53hADTPvyza32vf8lrE8+lAuqY
         4/ILuxCK+nNl8q1qqY6jfcyVA07Sx2eRYbDJz+dwsU85eDFgleJ3DOVmR8s7HeqMGM8T
         GYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66xVPwdcfssjg8x3e8OZtHo+7glyERJG9zKbkn+ZIAA=;
        b=aOkpVS632Y6VLvagoJr9atNTZoDsYoic9BDBvrukxUecVgRGPKzGRLTZPf3HoSnnxR
         lPVdz3i76eby8L4HUVp/4evse2OeS7pTvDNTFYDqtUVSJ8h8VfdDp7Ktonj4t61S2Pw3
         oKDTnh1+a6O6gS027LpCWgSdQrkdZcFGLZukEMnr6H2clnSpAF6BQw0ZOVQ2XmnS0RIS
         /Au3orD0JF+PJHDarXd+NA5rss8wWNCczxtj94C7ueKyAfAGBBztxiTwvdWsDbS183vB
         AtBddBmazAkAGcyRLxHuSIiLSiJAIFryRMsjieKo5801qTmoqhv4/BpK627Ovp/WFq5r
         7VUA==
X-Gm-Message-State: AOAM533EBwlRcvmhLX1efvx3RfC2I9Qwhpg6B5aJ0CaXF4JUm79x49VM
        vMXQgHQcqQloJgD7wUAi//8=
X-Google-Smtp-Source: ABdhPJyJwEDPVi9sogNeRAJH927/ULMFqGWYyGtHBVF7osohqHy6cKaFQYTunD8pUH3KHrS6SDXgfw==
X-Received: by 2002:a63:78d:: with SMTP id 135mr6284503pgh.116.1627069035386;
        Fri, 23 Jul 2021 12:37:15 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:55b1:90d5:6a79:755f])
        by smtp.gmail.com with ESMTPSA id c14sm38629057pgv.86.2021.07.23.12.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:37:13 -0700 (PDT)
Date:   Fri, 23 Jul 2021 12:37:10 -0700
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
Subject: Re: [PATCH V4 3/5] dt-bindings: power: reset: Change
 'additionalProperties' to true
Message-ID: <YPsaZnnzNUS00zFg@google.com>
References: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
 <1620800053-26405-4-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620800053-26405-4-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 12, 2021 at 11:44:11AM +0530, satya priya wrote:
> Change 'additionalProperties' to true as this is a generic binding.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
