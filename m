Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9EC3A3A6D
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2019 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfH3Pe1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Aug 2019 11:34:27 -0400
Received: from [110.188.70.11] ([110.188.70.11]:3540 "EHLO spam2.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727751AbfH3Pe1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Aug 2019 11:34:27 -0400
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id x7UFXCjY038545;
        Fri, 30 Aug 2019 23:33:12 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id x7UFWrRJ011867;
        Fri, 30 Aug 2019 23:32:53 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from [192.168.1.193] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Fri, 30 Aug
 2019 23:33:12 +0800
Subject: Re: [RFC PATCH] tools/power turbostat: Add support for Hygon Fam 18h
 (Dhyana) RAPL
To:     Calvin Walton <calvin.walton@kepstin.ca>, <lenb@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1567157008-29679-1-git-send-email-puwen@hygon.cn>
 <fea87715422ac21ca5d439e91ff45074069ada20.camel@kepstin.ca>
From:   Pu Wen <puwen@hygon.cn>
Message-ID: <0817315b-7e5a-cadc-af95-cc067cb2620c@hygon.cn>
Date:   Fri, 30 Aug 2019 23:33:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fea87715422ac21ca5d439e91ff45074069ada20.camel@kepstin.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn x7UFXCjY038545
X-DNSRBL: 
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019/8/30 22:27, Calvin Walton wrote:
> I was a bit worried about these two chunks, since as far as I know AMD
> has not yet released any processor with family 0x18, so there might be
> future conflicts:

Hygon negotiated with AMD to make sure that only Hygon will use family
18h.

> Please add a comment on the 0x18 case in the rapl_probe_amd function,
> something like:
> 	case 0x18: /* Hygon Dhyana */

Okay, thanks for the suggestion.

> Feel free to add a
> Reviewed-by: Calvin Walton <calvin.walton@kepstin.ca>

Thanks a lot.

-- 
Regards,
Pu Wen
