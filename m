Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3F0405CD5
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 20:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244321AbhIISX4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 14:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbhIISX4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 14:23:56 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB71C061574;
        Thu,  9 Sep 2021 11:22:46 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id w8so2657632pgf.5;
        Thu, 09 Sep 2021 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cS1iTpx2iIEsb5X2+pzRvzep4hwsHFWtChlzadUiG9I=;
        b=bxRmxhOlHYKuobsxPOTAiq3+MtHyF2JYdf41wvryacSPL3lw0hXKl8NFRFNvZ9rYhu
         PM0PQyjvJX3E0YFeewQAIJVKTMRGRtQVxiHuh2to+5R+7sb7+uNXqeDj3ONnqfWwV4uU
         OQDHx/3G7zHs8T1iAz9a8ruINiZ7ue+3fsL4g1uEKZ53txJKPB8ceWj9V8OMfuqw772Z
         9ILftWW0CiB8n4rpiQsEc8SmYOWzZuiJAxCZT0WiI/HjEW2EIJACuAu8tLVwcMP/rrg8
         rA3NVcdfrmEKafMelBcriWjKm8SQhY10y1NF8eRq4P2zU+cI96CdbxledzSAKkSYrlgL
         7ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cS1iTpx2iIEsb5X2+pzRvzep4hwsHFWtChlzadUiG9I=;
        b=cdTaWOuP9bKtDE6IIdIOGJ3ghWz+bo4xRMO7SvXP3qhmM5bzFzZvdcbPYuAYoUf9Kd
         d5zUBQN6647ZlTQ9oCqf2ctOpRJefQUsIuWYUKw+7/SSmjqPO7oJWdl/4/ImZBLV6g79
         7kmejvvd706OGGKVGhboSFNUp2nhQK+xfF3YiKPQNPBzQnkB3MuYaRppcJAaxIe5h4IZ
         YIPEwj73Vc0k3s06T034UOHxuLSozJsw4t62ittXs8DNoPE0sWrLvoXUqfWXE/HePfTZ
         wDFHjsiEql1P+EEcQcKE5DJx1e8R18cdwlFxU50sSgWCZiZKS8wOkCllcNG6fNLqVjTh
         ONQg==
X-Gm-Message-State: AOAM531Q6O7m+DwVCgPdScRPc6q7pieBo38CykHCS+wbxgEDwMdGJ8Ba
        wBAjESN6UvOhm/0+G5s2wFA=
X-Google-Smtp-Source: ABdhPJwLmIXWo3nwtew/RnVH4oYPEXF2Dglq2hOuAUcs7ibnTxReTPYMsA0w2diUTbVYQymmt/Bfvw==
X-Received: by 2002:a63:f512:: with SMTP id w18mr3779280pgh.280.1631211766039;
        Thu, 09 Sep 2021 11:22:46 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h4sm3364867pjc.28.2021.09.09.11.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:22:45 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Cai Huoqing <caihuoqing@baidu.com>
Cc:     =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: bcm63xx-power: Make use of the helper function devm_platform_ioremap_resource()
Date:   Thu,  9 Sep 2021 11:22:44 -0700
Message-Id: <20210909182244.3387118-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908071417.494-2-caihuoqing@baidu.com>
References: <20210908071417.494-1-caihuoqing@baidu.com> <20210908071417.494-2-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 8 Sep 2021 15:14:16 +0800, Cai Huoqing <caihuoqing@baidu.com> wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
