Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156A63392FA
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 17:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhCLQUM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 11:20:12 -0500
Received: from vern.gendns.com ([98.142.107.122]:50542 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232248AbhCLQUA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Mar 2021 11:20:00 -0500
X-Greylist: delayed 930 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Mar 2021 11:19:59 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+qNUJ0kNliQ789clm1cti7szUu79mPPfW2uq8eLN8g4=; b=KiuKcLURPJar5XVuxAn2j0n+qR
        PtSxnE64RkZap1tbc98NBQhAzpb4NtkqdvU1+r2zl8X45ULW+bYDCJ2MPK7Q2mpxRY8uQSSfVkarU
        SaYNjVIGKg9IN3CJcsfhLZhQC/M1tbW4PxHyO/79LBHporfGthZFX8lV2geiTCx9LbZWei+XVVpRj
        /EyXt5kXNLV9w4L4dwJOPO60/N/TX8Guv1dCYQzT7bZK5f89weIwji9MX/krwDf8KldR/1tyy0VDi
        QOyDfKTHtCsK4R429AM8YocuHHC22GwcbPmnUFoFbrQitrTcj2YyMb0p238/GO9jYnXGDGYp5MaXe
        sG8SybDQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:43996 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1lKkH4-00047A-TX; Fri, 12 Mar 2021 11:04:26 -0500
Subject: Re: [PATCH 19/38] dt-bindings: power: supply: lego-ev3-battery:
 Convert to DT schema format
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
 <20210312154357.1561730-20-sebastian.reichel@collabora.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <62652945-b4b0-29e8-f8ea-343bb848652d@lechnology.com>
Date:   Fri, 12 Mar 2021 10:04:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312154357.1561730-20-sebastian.reichel@collabora.com>
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
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/12/21 9:43 AM, Sebastian Reichel wrote:
> Convert the binding to DT schema format.
> 
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>
