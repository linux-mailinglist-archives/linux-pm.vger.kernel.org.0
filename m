Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1581CD096
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 06:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgEKEW5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 00:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725790AbgEKEW5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 00:22:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7DBC061A0C
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 21:22:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k12so16480267wmj.3
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2020 21:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=o4xnzYVyuC6111/k6qlkYw+Jq59DyNMy7m+FNNQ5p08=;
        b=AnJ1rTDcWpE+dgcz3zIdeHJg4ZBk5ATq1zsU2ubaD6BfNbeTmDMUoAvXvZpiaCurlJ
         GjrigAI4LPLprdxORkMxWBhhqQ74pO55NP7SMkeYXANzfhWEoBjAu+clv2L0f04weUzt
         TgrkLBaPt6YK+G8ky6OvIfMGOhJ/wpbkRWMmYYo9o+Ujgnv8MCeZvH2nlAyIZN1GlZ+n
         3IeeIdIgDBVQVeIlLv4DuTvtyh2oE8Yhe/cUcmtg2feuRgZ1j9iRigFpl+kardNVMMzt
         pOUIMPl2i9nHlO1t/OYOoN5tp/LjMVXRryjgvCuiihX8vwG7Z7n9wuGizArBeXvbNqq0
         gwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=o4xnzYVyuC6111/k6qlkYw+Jq59DyNMy7m+FNNQ5p08=;
        b=Ea9YlMFoHj+SZa5WPaWmSnT1jS4v7R3tarrqW4CoVedUcAeO9SgWffAwx9lQUlQcbN
         kgyf17m4yzL+wGyLzBX6G5p9bC6K7GiXs+k3+JP7+Gg5eIHU2jhzCvhpWP3lMheV9/79
         785FiesNztWMqc/CqUQsWg0sLZyzV0/VF1yctIZ5FpyhQdU4IPddwcvfztJ/B1lviEDu
         P1YxaZHtvT75DtVH0mzeBU8aljBUBP9lK8qKgSkIUawZ3XdA5z4x15Adr55r6H3XHpXA
         eoJcnor4iuDdOelSTkdwAXC1+fzY/wJmrPa2x1wxLCPXBk9WPobozBB1pTHzCrB2tZI/
         o5Dg==
X-Gm-Message-State: AGi0PubPtoCLD2JwQGfRAvy0MvGqK6uiX0h/5hYY0fK1ZMl17R/8lffc
        lVUnQ+L2W4rTWAeoMON1sgKq2TWygNVnKIUWv3RBbDSj6NLlyQ==
X-Google-Smtp-Source: APiQypIgSJeVkIGwLjaMTF8P/e8pVXmbJZdDBQ5F1SyvvWiGAp+76UWQQFz897NE66aB2YjjqSSchnQTbIwYTQhDg9k=
X-Received: by 2002:a1c:2348:: with SMTP id j69mr12781262wmj.11.1589170972707;
 Sun, 10 May 2020 21:22:52 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <chris@colorremedies.com>
Date:   Sun, 10 May 2020 22:22:36 -0600
Message-ID: <CAJCQCtQ=1=UFaCvPO99W0t9SWuK5zG4ENKYzq2PgJ36iu-EiiQ@mail.gmail.com>
Subject: 5.7 sleep/wake regression
To:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Got an older Macbook Pro that does suspend to RAM and wake OK with
5.6, but starting with git 47acac8cae28, it will not wake up. Instead
it has a black screen, gets hot, fans go to high, and it turns into a
hair dryer. So it's a regression.

I started a bisect but, that's not going well.

$ git bisect good
Bisecting: 123 revisions left to test after this (roughly 7 steps)
[7af51678b6d367ee93dc3d21e72ecf15be50fcb1] docs: deprecated.rst: Add
BUG()-family
$ make -j8

...15 minutes later

  GZIP    arch/x86/boot/compressed/vmlinux.bin.gz
  MKPIGGY arch/x86/boot/compressed/piggy.S
  AS      arch/x86/boot/compressed/piggy.o
  LD      arch/x86/boot/compressed/vmlinux
ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple
definition of `__force_order';
arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here
make[2]: *** [arch/x86/boot/compressed/Makefile:119:
arch/x86/boot/compressed/vmlinux] Error 1
make[1]: *** [arch/x86/boot/Makefile:113:
arch/x86/boot/compressed/vmlinux] Error 2
make: *** [arch/x86/Makefile:283: bzImage] Error 2


I'll give 'git bisect skip' a try and see if it'll get close enough to
the first bad commit.

Anyway, all of 5.6.x sleep/wake fine, and all of 5.7 do not, i.e. it
hasn't been fixed in rc5. Thanks.


-- 
Chris Murphy
