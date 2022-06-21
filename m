Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FC0552C20
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jun 2022 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347432AbiFUHcu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jun 2022 03:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347291AbiFUHbs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2022 03:31:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E222BF0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2022 00:31:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F6AF66016BE;
        Tue, 21 Jun 2022 08:31:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655796668;
        bh=rAKs9yjRTDBoZUtYmdiGgoemJTNqX+cPNuk68ipXIpQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A8H7ovwbdQLE7ZG3thuhfFb0GZbETc7bFYb0ZnshKAa5KCSr3aUSNnYKes0ROCecS
         GXL7jpqSu8yzV9TzPICs0rxj8eKYYnUyahhmekkaFafxOa2Now/8P1JKdCLoKYYL7n
         0sn+MSzoeEGXfi3VF+B4saFeU3tetg5w9crF0GSu93XqW6n59/6AaJYo05Ob6cX5Tb
         SeoDFSUjNzl63uyNgT5zPaRFusZc3nVedSQQViYCZgDREOzob4q/6uCaDwk+qmCDoa
         vy/Imr/oLcoIzV66CccGCdvmv3REHteFi7WAIA/mtdjLoMcY5K/X6PXWx+BEbztV1i
         lv5wbyTzhXKYA==
Message-ID: <371d31a5-fad1-86ac-2c8b-0d1100b26a6d@collabora.com>
Date:   Tue, 21 Jun 2022 09:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] PM / devfreq: mediatek: Fix unnecessary check of drvdata
Content-Language: en-US
To:     matthias.bgg@kernel.org, dan.carpenter@oracle.com,
        johnson.wang@mediatek.com
Cc:     linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20220620154347.14756-1-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220620154347.14756-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 20/06/22 17:43, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Probe function will error out if drvdata 'mtk_ccifreq_drv' is null.
> So when mtk_ccifreq_target get's called, the drv pointer will never be
> NULL. This fixes a static checker warning.
> 
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

