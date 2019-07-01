Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765E45C325
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfGASjx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 14:39:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfGASjx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 14:39:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8C0E36028D; Mon,  1 Jul 2019 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562006392;
        bh=ecZCP0Nl2MvYdNc2PJ+G+AX8dhZHCBiv1DZ4bQurLhc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K/7usMnyAV2CIYxBNfXpgHdLeUMcCsknMVpBP35DHG2V+UP+hO6D8curADy8aiAft
         Biu1fmmU9WljiNeyT/cLwG5iLPqK5kqaB/H4nusUnygVqhPI3PtNMPrIK7+/N5IFZW
         jRWgCBNuydCHB+iRf1NFKq/nLZBES/g5zvsrkysw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 940AD6028D;
        Mon,  1 Jul 2019 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562006391;
        bh=ecZCP0Nl2MvYdNc2PJ+G+AX8dhZHCBiv1DZ4bQurLhc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OlYrV+PUD/QozjpxBy2p/EieCA4QwtgFpf13ybP2lZ1OJzn7NTcA4yuynVe5574ii
         Iqwo5W9FnzbP1OnSrgw4D0AjS7DcxVksD6f56ry8riJziBcSajIse6WrviiA8RxFn9
         sBdm4CuecGHdplapbI7tQsVpd006yMuIWj0OknR0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 940AD6028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 5/5] drm/bridge: ti-sn65dsi86: support booloader enabled
 display
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20190630150230.7878-1-robdclark@gmail.com>
 <20190630150230.7878-6-robdclark@gmail.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <a40e7406-892b-f3be-f309-8857085ff3c5@codeaurora.org>
Date:   Mon, 1 Jul 2019 12:39:49 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190630150230.7878-6-robdclark@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/30/2019 9:01 AM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Request the enable gpio ASIS to avoid disabling bridge during probe, if
> already enabled.  And if already enabled, defer enabling runpm until
> attach to avoid cutting off the power to the bridge.
> 
> Once we get to attach, we know panel and drm driver are probed
> successfully, so at this point it i s safe to enable runpm and reset the

is?

> bridge.  If we do it earlier, we kill efifb (in the case that panel or
> drm driver do not probe successfully, giving the user no way to see what
> is going on.

Where should the missing ")" be?


