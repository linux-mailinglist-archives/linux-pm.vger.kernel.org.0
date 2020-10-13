Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD7E28D368
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 20:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgJMSDz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 14:03:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39170 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJMSDz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 14:03:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09DI3rop078060;
        Tue, 13 Oct 2020 13:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602612233;
        bh=qzOJzu34mq4mDb7uWYaWmL6yfIvaed5Y4wmBqocHePs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SbkZfz4eeI56jY6esPhIn1LQtpEgGQKjwpsDSHZIVrXboZ1TraJA/4GkdFEDM0Z9E
         h9Bw/IhDM9/dP3fN9BiHfF6OCKBtp4LNJcwsFVopiOWcVHsjCZZZWGXdbvSvLb6hxL
         6BkWcw/jyq4nzEzNehhffB/VKqU6SzaFdNJCDhAI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09DI3rR7027585
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 13:03:53 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 13
 Oct 2020 13:03:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 13 Oct 2020 13:03:53 -0500
Received: from [10.250.67.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09DI3qNS006602;
        Tue, 13 Oct 2020 13:03:52 -0500
Subject: Re: [PATCH v4 1/2] dt-bindings: power: Add the bq25790 dt bindings
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
References: <20201009144112.3007-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ac52ca59-74f4-7ffd-544c-4a542e799ae5@ti.com>
Date:   Tue, 13 Oct 2020 13:03:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009144112.3007-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian

On 10/9/20 9:41 AM, Dan Murphy wrote:
> Add the bindings for the bq25790.

Also any updates on this series?

Dan

