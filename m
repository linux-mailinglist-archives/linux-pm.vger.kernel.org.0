Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903FF405CD2
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 20:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242783AbhIISXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 14:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbhIISXl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 14:23:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E03C061574;
        Thu,  9 Sep 2021 11:22:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w7so2639609pgk.13;
        Thu, 09 Sep 2021 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THDmTfHZykGsHbd1gtfdTxOoLuq5Az1VG+vSuI4psxk=;
        b=igkhAs5QpU9f7ASWfI2X6KygkBVpIHey74T4av01cepYcCISygoFfC6q5izgX25c66
         CXa0w3w6Gd31kbqmGrJcn+mc7dUM2nYTaRx6FuoU42rD48Nt9qxQ/j62HTPD8lVOS5KP
         krCYgP4oe5t3S0x5aqzmNQFyaBvmCyurLxH2aIT03r5W63uWHnIezTVEmXp9HeEnEQrf
         svLW0sdgFz8RtjSaKcR/a4Biogjc7Q7iKFZ4BoF4kk3Jsy+sTAwEYxPYd19+/oG8lKUM
         FNr6FTx4VW0iYkqwpfsBZPuGN81iSencRH69k8buOpGSlWQyfKzDwsL8TDpKPd+MuH8h
         qItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THDmTfHZykGsHbd1gtfdTxOoLuq5Az1VG+vSuI4psxk=;
        b=rpe7Zc0/My8Db2vZ+g4lZ7Bkprp/ik/HsC8N/7GW/NZDzbGbBP/Q+xeytrcUIDmJkU
         LgtQAb/Jt2OxdvngJJkJUYk4BR/2RzzUYdMytkFNfWciywCR5wHwwNtxXoRdyKrG+SsX
         qoKG8n6Wvhf/jbCnRvH/no+kKGzLPIzI0YsTmXQzsWGD5i2J6Osjf33JYYYgdQI7Xvmp
         DEPtYGrcGLdPZz/olFFOUaUepAzvmyQM4LcYctRWawzzByzA5L694yhVp4EgJ1XR3i9p
         JtsQK7jTqlSCun4mEghpzQfwE+mr0qKY1PoiiTLqSWgGf/doi93SJiGW2Vi/w1lkZ2sX
         l/Zw==
X-Gm-Message-State: AOAM531QSzwGhAs4Iwxe7KF27r9i5zLOqvlQ/3QuZi84Z/5EZqtetASl
        CcsARCw5FGY9qC7/EbJjOtY=
X-Google-Smtp-Source: ABdhPJyseSon87U3X17jk42MBDFTPGCZINt4jI5ZxwgBQA3Qvu/fvBdTAURXWlI8s1ehpoebGQjtTw==
X-Received: by 2002:a05:6a00:2291:b0:412:3db4:908e with SMTP id f17-20020a056a00229100b004123db4908emr4385796pfe.78.1631211750872;
        Thu, 09 Sep 2021 11:22:30 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y4sm2793855pjw.57.2021.09.09.11.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:22:29 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Cai Huoqing <caihuoqing@baidu.com>
Cc:     =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: bcm: bcm-pmb: Make use of the helper function devm_platform_ioremap_resource()
Date:   Thu,  9 Sep 2021 11:22:28 -0700
Message-Id: <20210909182228.3387009-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908071417.494-1-caihuoqing@baidu.com>
References: <20210908071417.494-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 8 Sep 2021 15:14:15 +0800, Cai Huoqing <caihuoqing@baidu.com> wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
