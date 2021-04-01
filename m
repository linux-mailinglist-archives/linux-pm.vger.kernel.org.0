Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A542F351F11
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhDASwg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 14:52:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56662 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238157AbhDASrt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 14:47:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FBByB0VdQz9v3xx;
        Thu,  1 Apr 2021 20:47:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7t9lNGv2CQzp; Thu,  1 Apr 2021 20:47:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FBBy969xyz9v3xw;
        Thu,  1 Apr 2021 20:47:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29ADA8BB43;
        Thu,  1 Apr 2021 20:47:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zesb-6aN77SL; Thu,  1 Apr 2021 20:47:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B5F58BB28;
        Thu,  1 Apr 2021 20:47:45 +0200 (CEST)
Subject: Re: [PATCH 0/1] use crc32 instead of md5 for hibernation e820
 integrity check
To:     Chris von Recklinghausen <crecklin@redhat.com>, ardb@kernel.org,
        simo@redhat.com, rafael@kernel.org, decui@microsoft.com,
        linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210401122458.12663-1-crecklin@redhat.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <22595ae7-2ab5-2e6b-01d7-6b284dc8b0c2@csgroup.eu>
Date:   Thu, 1 Apr 2021 20:47:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210401122458.12663-1-crecklin@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Le 01/04/2021 à 14:24, Chris von Recklinghausen a écrit :
> Currently, suspend on x86_64 fails when FIPS mode is enabled because it uses md5
> to generate a digest of the e820 region. MD5 is not FIPS compliant so an error
> is reported and the suspend fails.
> 
> MD5 is used only to create a digest to ensure integrity of the region, no actual
> encryption is done. This patch set changes the integrity check to use crc32
> instead of md5 since crc32 is available in both FIPS and non-FIPS modes.

Why not put all those explanations in the patch itself ?

Because text in the cover is lost, so a cover is not really usefull for a single patch.

> 
> Chris von Recklinghausen (1):
>    use crc32 instead of md5 for hibernation image integrity check
> 
>   arch/x86/power/hibernate.c | 31 +++++++++++++++++--------------
>   1 file changed, 17 insertions(+), 14 deletions(-)
> 
