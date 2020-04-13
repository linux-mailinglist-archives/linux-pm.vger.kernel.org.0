Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD311A6C98
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 21:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbgDMTjU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 15:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387935AbgDMTjT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 15:39:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF70CC0A3BDC
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 12:39:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h26so8221wrb.7
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to
         :message-id:user-agent:date:from:to:cc:subject;
        bh=IpU3bmnAuavTGpOWOCyOk9k/d+5vSrxKFHnziQaa0uo=;
        b=OdI47+/0Y76WPvZUiSXHJ2n2xtV/X3uAftItHgsrhDHG+scI/Ezr2kDoSG5CE3haIE
         J4BNquPt4PTq4+mDjxXaGkHkF6GE5GNQedtyLxHCypyC4A85See3gQcNk0Uzhd6DGO36
         kbhtrq0uVOqWMs309//Osdv7Ylq+olkx49l7RJSl5ot54sHpzhC2H/pFf05UcZKmfl6/
         NYshr+mFfZcJTN3i3FqsREx4Q4rZhLqCfEDBzZIBCj4VQtsadv1Ibc6Am1++4Z+5sBeI
         joPYNi4+uAqbXT2WMXP8/vgjWpXLI7kYZ6jAfhwy1mbJc56mPJgMcL3mmEa0eSS1mzY0
         vjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:message-id:user-agent:date:from:to:cc:subject;
        bh=IpU3bmnAuavTGpOWOCyOk9k/d+5vSrxKFHnziQaa0uo=;
        b=oyDrdW5mIBZq0e1XttD6FPB6fYj+4yORBmpKZS7JM2pFr3BpEJSiya6WFVHTWkA70D
         LmOxGmEKpdxKaHvFaF2baIlMq61EbWcFaK9lggUP0zGIXUn4Y1XqkQyHOMkpBgr1kN4p
         wtPO25r9TaiXC5e+doqz6/6pc22QPsQZsBPqvUe897yTXNlR1Tw/nCaZgnZmsF3b893H
         30Ggb58LmzbuvbrtoKI+hdjXOZ0P8pC9XgBMi2cjwZ6xFiC5yTKc2HqszHF9nvKBcW3m
         uC4REvOpDR41klVvkEt3CFUlHlO1mtIaunhIyQWYYh49ncVmgiISe2mMmTh4uyZi0jv6
         EKzw==
X-Gm-Message-State: AGi0PuZtweV5rYinXxmKlPkGIaDoqY34tMFgutsoz2cVvDnuLj0vpAHP
        lFO7vagDLxYkioWW1sa3Rt3lfFI2Woo=
X-Google-Smtp-Source: APiQypK8K72+wDiWtP4PikRaBK8VW0+KqU7Bj09i3y7++5LgXkjkUIT1i1cOcIZQKSvYEm+9HCacbA==
X-Received: by 2002:adf:91e3:: with SMTP id 90mr20218778wri.206.1586806757616;
        Mon, 13 Apr 2020 12:39:17 -0700 (PDT)
Received: from dumbo ([2a06:1700:1::7])
        by smtp.gmail.com with ESMTPSA id s6sm15500214wmh.17.2020.04.13.12.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 12:39:16 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jO4vK-0005xs-MW; Mon, 13 Apr 2020 21:39:14 +0200
Message-Id: <20200413190843.044112674@gmail.com>
User-Agent: quilt/0.65
Date:   Mon, 13 Apr 2020 21:08:43 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 0/2] Preparing to phase out uswsusp
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear maintainers,

  it is my understanding that the usermode software suspend is not any
more the first choice for suspend/hibernate needs (uswsusp tool did
not receive any update in years).

This small series aims to better separate the kernel side in view of
a future phase out.

Marking the new option as deprecated and disabled by default is quite
extreme but I've not any specific agenda for pushing it that far,
it's just my interpretation and could be totally wrong.

Kind regards,
Domenico

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
