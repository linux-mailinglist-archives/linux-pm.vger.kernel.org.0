Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7853A1C8363
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 09:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgEGHYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 03:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGHYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 03:24:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A729C061A41
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 00:24:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w7so4198872wre.13
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to
         :message-id:user-agent:date:from:to:cc:subject;
        bh=Kp16k5s9kVk1OOFRC0SZ7lfHon+lehcxyZ+HsGWG+8Q=;
        b=Tl8ypGE/chYgwhUzjJXUeUAuKDOvm40sYhfH7Fwa2S0+OjLTMxlzWNZpebU9fvdxgd
         L6pJTilUVmzCQH4bOF8L2BofnZ7t7g88EP+oOYJ7lcHf9XO9OyhKUbFFaBxULYca/l1j
         bDSCdXO6SDvgp7KD19SE6zVbsWgGDQgLTUFH690ZgUtqfgvXHT4FokQqvYjE5FgKne9Y
         LjzvHtLc7jga7tpekFmFYTwpvVt5ALSIQgZoR93tqcQC5yLSkdyXD6Pl9FPnRdDjlscq
         v0waWozlSZpR4a1aCzlUbHG3+ez64bqrgC/5ptPmNsH+neubY6EyqJCK+QUQO+FYzPnw
         q3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:message-id:user-agent:date:from:to:cc:subject;
        bh=Kp16k5s9kVk1OOFRC0SZ7lfHon+lehcxyZ+HsGWG+8Q=;
        b=AfYr7/TUX5LPplw4PZ7ywCO6B/gLDhCmvtzTbX/dBDb7OlhsXirEBR61QJi0Ty6hGt
         NAZiwnUStIgcPAcAiSd+hSeB/97F3TweQxT8V4OoJJTFFdn9NcVU9dRcKHzD04H+LVDR
         Juz7nFV/cVnzUejAZDdTEbEJo4+O+8JxuMXyfLssFslOGq+VWzxtSsVTi77v/2eWG5n8
         VsA8+Evh6kN7XxtdtpIlhXf/ur2BThnLRFty/HEEodX9CQRxkbh5KhYOPXS4Y8v99XcS
         HwzIlc6W1/69kBXJpgl0MowDDoXLiwTcr1JvZWhkfO4zZJl+WGkF2X2t2oMie3YYihW0
         tLbQ==
X-Gm-Message-State: AGi0PuYNp4cWM/TLXY33FqfgmvrbEZ5j2fjXm0xCM65BcWS+58CsewhQ
        zw8TnfmH9dt621TvzxTRur0sF4UeDus=
X-Google-Smtp-Source: APiQypI5hDD+OuM4d4Nn0NM5J4+x5DaRRdnBSAUZYLLPuKed2yJuz7NdX0SiubTl7eSXYv2TNMGvAg==
X-Received: by 2002:adf:b786:: with SMTP id s6mr4378829wre.287.1588836283144;
        Thu, 07 May 2020 00:24:43 -0700 (PDT)
Received: from dumbo ([2a0b:f4c2::1])
        by smtp.gmail.com with ESMTPSA id m188sm6329932wme.47.2020.05.07.00.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 00:24:41 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jWatc-0003zs-1y; Thu, 07 May 2020 09:24:40 +0200
Message-Id: <20200507071951.635743820@linux.com>
User-Agent: quilt/0.65
Date:   Thu, 07 May 2020 09:19:51 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH 0/2] hibernate: add config option for snapshot device
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear maintainers,

These are the improvements over v2 [0]:

 - switch back to atomic_t API, refcount saturates when incrementing
   from zero

These are the improvements over v1 [1]:
  
 - move the mutual exclusion to hibernate.c (it was in user.c)
 - switched to refcount_t API (it was atomic_t)
 - the option is enabled by default (it was disabled by default)
 - remove the premature "DEPRECATED" marking
 - drop the redefinition of mutual exclusion helpers (in v2 they are
   owned by hibernte.c) in case the option is deselected
 - add the help message to the config option

Kind regards,
Domenico

[0] https://lore.kernel.org/linux-pm/20200501151452.621900831@gmail.com/
[1] https://lore.kernel.org/linux-pm/20200413190843.044112674@gmail.com/

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
