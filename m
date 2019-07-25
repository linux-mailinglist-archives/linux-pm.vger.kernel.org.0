Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006BA7511A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfGYO2m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 10:28:42 -0400
Received: from vern.gendns.com ([98.142.107.122]:53982 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfGYO2l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jul 2019 10:28:41 -0400
X-Greylist: delayed 1209 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2019 10:28:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8iXF3z4I/1bFhPymp5brEezEOAt+VD8wjloraO/Zwfk=; b=EXZ5L71uP37YRG8OARqdv6Xg/0
        RIycvmcz3YOUZ0lh/L7nIdAPHoDU74Ucg9nrvCgA6rkrGvJbgukLUmvm56LRBVfSsBHgf7sp+oGfg
        P1n2E2cIznyFkE6WsIIUQe9Yb4A3ZOsTedEF5WXsXF8QEFGfQxPjH3z/cT2fi3Raj5YCuXmE3HsrQ
        f6rylb6AqSyWzPSS4OQIu81FVjPKBUV7PBTjGtlvyMVvQEwkCFNZGbNzOAMIOm2VCVtJKaOI8wf+U
        eVQUfi6Y4W9tptS0LJZSkugqoi8vNNwv16UNEmLySJwnwHcaeHb4gLyMF9+RtHQSdU75lO/vA9ECC
        qUHojtRA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60968 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hqeQ1-00Givk-AR; Thu, 25 Jul 2019 10:08:29 -0400
Subject: Re: [PATCH 1/1] power/supply/powersupply_sysfs: Add of_node name to
 uevent message if available
To:     Richard Tresidder <rtresidd@electromag.com.au>, sre@kernel.org,
        enric.balletbo@collabora.com, ncrews@chromium.org,
        andrew.smirnov@gmail.com, groeck@chromium.org, tglx@linutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1564040858-24202-1-git-send-email-rtresidd@electromag.com.au>
From:   David Lechner <david@lechnology.com>
Message-ID: <9a10b934-e7f3-c95f-6250-8a857bdfa912@lechnology.com>
Date:   Thu, 25 Jul 2019 09:08:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1564040858-24202-1-git-send-email-rtresidd@electromag.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/25/19 2:47 AM, Richard Tresidder wrote:
> If the of_node name of the supply is available from the devicetree binding
> then include it under the var POWER_SUPPLY_OF_NODE_NAME.
> This helps where a consistent name is known via the device tree binding
> but it is hard to identify based on the usual enumeration process.
> 

Would it be possible to use of_device_uevent() instead of introducing a new
property?

