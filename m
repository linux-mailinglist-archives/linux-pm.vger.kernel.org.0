Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EA624FC22
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHXK7U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:59:20 -0400
Received: from foss.arm.com ([217.140.110.172]:59556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgHXK7T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Aug 2020 06:59:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88A551063;
        Mon, 24 Aug 2020 03:59:13 -0700 (PDT)
Received: from [10.37.12.65] (unknown [10.37.12.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D7F03F66B;
        Mon, 24 Aug 2020 03:59:11 -0700 (PDT)
Subject: Re: [PATCH 1/3] memory: samsung: exynos5422-dmc: rename timing
 register fields variables
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200822163218.21857-1-krzk@kernel.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d8d7b2bb-d277-4e48-889c-16110f4d594d@arm.com>
Date:   Mon, 24 Aug 2020 11:59:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200822163218.21857-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/22/20 5:32 PM, Krzysztof Kozlowski wrote:
> The driver has file-scope arrays defining fields of timing registers
> (e.g. struct timing_reg timing_row) and actual values for these
> registers per each OPP in state container (struct
> exynos5_dmc.timing_row).  The meanings of these are different so use
> different names to avoid confusion.

Good point

> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Acked-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
