Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC24228D361
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 20:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgJMSDR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 14:03:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56464 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJMSDR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 14:03:17 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09DI3FB6092528;
        Tue, 13 Oct 2020 13:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602612195;
        bh=UJlIe/Y1UnEj2EVL0fmpbETtgVopdOZvwXEzD5BF4c8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pOMe11T9VGOqTRis3/P3Bwa5riOG0rlluSij32nhFZm0QRgRfzwSvirnKUn3LOmHS
         O372Kyq/fW5guNBiDxLyo2FfhlzgaHy1/2NpcD39yVwGg8/wQY6W2iZvjJ1BrZnZ8J
         fC6mBev8/H+trZCbg/Orpk3pcegOgX5HdTLkoDt0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09DI3F4w081843
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 13:03:15 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 13
 Oct 2020 13:03:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 13 Oct 2020 13:03:14 -0500
Received: from [10.250.67.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09DI3Dqa005493;
        Tue, 13 Oct 2020 13:03:14 -0500
Subject: Re: [PATCH] power: supply: bq25980: Fix uninitialized wd_reg_val and
 overrun
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
References: <20201009121205.28178-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f75856b4-88b5-38af-8d31-a7c19c978f26@ti.com>
Date:   Tue, 13 Oct 2020 13:03:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009121205.28178-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 10/9/20 7:12 AM, Dan Murphy wrote:
> Fix the issue when 'i' is equal to array size then array index over
> runs the array when checking for the watch dog value.
>
> This also fixes the uninitialized wd_reg_val if the for..loop was not
> successful in finding an appropriate match.

Might want to pull this into next as well this is a 0-day bug fix

Dan

