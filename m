Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5531253309
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 17:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHZPLH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 11:11:07 -0400
Received: from vern.gendns.com ([98.142.107.122]:45858 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgHZPLG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 11:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=70Brejj40/UxoRT5H6gZ3Zo/jXzzFg1p4XCC31HmDqA=; b=CiZVPrHrO4fSCa6MEXAaCKLBga
        rwnyRpTRVXNOpI2mbi/wN99ZJdoqPaKXDIoQv3MWl/9rDQr6LpO3M/PN4tC8Zmr5Llxn9Jlue1fJJ
        2kC6FpttrRI4788eCpcGmprnnUswv4tbm1pHW6O+iBS2EFgblPYoAvAgezMiPD+7QEEPorFWtdqrU
        knXeTP1lch6aS5X3fnGpyRTQl0uJZsRTBCSp+EdV7O/+cD9tOGFTXMCqe1QZs21r3QkpTw9W2yQAg
        MU6NImW3Xuo49B+4KKHuODJq9T9Wj/Bzlr3QDtFfRuXBJVbQ2/9tYOD7PQwrkc8Y7ipFif9SnjD9P
        aaWUJORg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51472 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kAx4p-0002Yn-HO; Wed, 26 Aug 2020 11:11:03 -0400
Subject: Re: [PATCH 5/5] power: supply: lego_ev3: Simplify with
 dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200826144858.9584-1-krzk@kernel.org>
 <20200826144858.9584-5-krzk@kernel.org>
From:   David Lechner <david@lechnology.com>
Message-ID: <bf10bb56-a8fc-02b4-809c-2592c2618f19@lechnology.com>
Date:   Wed, 26 Aug 2020 10:11:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826144858.9584-5-krzk@kernel.org>
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

On 8/26/20 9:48 AM, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

