Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61247BC7FF
	for <lists+linux-pm@lfdr.de>; Sat,  7 Oct 2023 15:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbjJGNir (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Oct 2023 09:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjJGNiq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Oct 2023 09:38:46 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC656BA;
        Sat,  7 Oct 2023 06:38:43 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S2mbN1q7sz9sWF;
        Sat,  7 Oct 2023 15:38:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1696685920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hhIxgXcMTI07OIwnl/nEJEp5sHPAf/BMqIZfrNcaZdk=;
        b=k1OvJXjgDDK6PmYiQejoWuCa0GsJsWqmgybyjlRVBHlKnZPUpURtdQggC5OUzNQksb/Uqo
        LDenIW62jzACBNEB85xuNlUfbKxtohif7umEXvVRxDpYhnnC9GsgL7QjyUpO8e+dBMzQRI
        K+U/1afm3Aiw5hwUMcyGT0288tPRoV6jTlgYY7xIh+/YuA+NFgeLjp/P30yZ4ShzXhuv3U
        jL5d3CNty/+p4I4kdrR1NhUQdTR2KBRXZ9stXWtWvBObQfNmo+MOYkBG1urJBruv03AAYR
        7jtad5pZDANyh98tPZyy2XuET1XPDzy0DBl9KmikGhNxy+NkoYOAMENLRH274A==
Message-ID: <615ae9bd-f220-4189-aca2-7aa946444043@hauke-m.de>
Date:   Sat, 7 Oct 2023 15:38:39 +0200
MIME-Version: 1.0
To:     stable@vger.kernel.org
Content-Language: en-US
Cc:     ivan@cloudflare.com, skhan@linuxfoundation.org,
        linux-pm@vger.kernel.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: Backport "cpupower: add Makefile dependencies for install targets" to
 stable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4S2mbN1q7sz9sWF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Please backport the following commit back to the Linux stable kernels 
5.10 and older:

commit fb7791e213a64495ec2336869b868fcd8af14346
Author: Ivan Babrou <ivan@cloudflare.com>
Date:   Mon Jan 4 15:57:18 2021 -0800
     cpupower: add Makefile dependencies for install targets

     This allows building cpupower in parallel rather than serially.

     Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
     Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>


When I was building cpupower from kernel 5.4 using buildroot I was 
running into this build problem. This patch applied cleanly on top of 
kernel 5.4.

Hauke
