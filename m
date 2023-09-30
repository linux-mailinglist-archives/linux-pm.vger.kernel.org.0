Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762B87B4381
	for <lists+linux-pm@lfdr.de>; Sat, 30 Sep 2023 22:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjI3U2V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Sep 2023 16:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjI3U2U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Sep 2023 16:28:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF97CA;
        Sat, 30 Sep 2023 13:28:18 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5072B6607285;
        Sat, 30 Sep 2023 21:28:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696105697;
        bh=hRlP4DfBi86OovKpM21F/xWPEezlBHK/OG5lsM8V+Sw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fMB7aJfZXrh7iex7stsguBcQ2tYDcR2fIaw1W/etZfGkG/Wrv62zz7Srvy0C2hJGb
         TBQHVnX98LXJfG2mQNd9HTXHBe0jJMpptCsRDNCfJ5cXDsmVZsHG+7upLb7r8NuX4y
         bFCUPVMaoDWELQOellD7+DFN21ySb9m+Vsli+QIM6BEIEupnVgCDoMXiXA70l/rRrc
         Pswf6eGDb4kx39se8pvmqhIMqrukMF3y/mulv3fSg1dZv58OVRmKVFUlA6aei8TLCq
         pGu+XAmesx4FP0B3x9iGLrtuGY1mkGyGGv+v/vruTyEeOo6mu7CnW2mzihvLn6wSbH
         zaItx0xGQGX+g==
Received: by mercury (Postfix, from userid 1000)
        id 2184910603F9; Sat, 30 Sep 2023 22:28:15 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Konrad Dybcio <konradybcio@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <c46b4408-bf1d-408d-9e6b-16b0ad272532@moroto.mountain>
References: <c46b4408-bf1d-408d-9e6b-16b0ad272532@moroto.mountain>
Subject: Re: [PATCH] power: supply: mm8013: Fix an error checking issue in
 mm8013_checkdevice()
Message-Id: <169610569512.214910.12711679981052235128.b4-ty@collabora.com>
Date:   Sat, 30 Sep 2023 22:28:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 27 Sep 2023 15:41:05 +0300, Dan Carpenter wrote:
> There is a missing "ret = " assignment so this checks the same "ret"
> value twice.
> 
> 

Applied, thanks!

[1/1] power: supply: mm8013: Fix an error checking issue in mm8013_checkdevice()
      commit: 8f8e9b7388514d937843337140f18ceb0f3da6eb

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

