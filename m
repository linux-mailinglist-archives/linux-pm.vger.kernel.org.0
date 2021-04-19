Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448BF364EDA
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 01:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhDSXwo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 19:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhDSXwo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 19:52:44 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC0BC06174A
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 16:52:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id y12so27514681qtx.11
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Tvkr+mPSZ+ps5DppAGK1+r+Pdo4K4oVliDzSpuZeEcw=;
        b=CtItF8OToAHckxW4i9k8/+6ccOS+08mGOUvPXACScNE6B4Yei80WiWMj5Z50jJFjFF
         8KY3c1N+x+iIqe9M2Qm0AddKOZwF9SeUUNYdTji6732Wx0cyfspfvtECD5WAxvzhlQeg
         5gNThYBrSKuVUsxgjVac03LIJuO2eilwxkQE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Tvkr+mPSZ+ps5DppAGK1+r+Pdo4K4oVliDzSpuZeEcw=;
        b=LAW9NhjcxUt1KCMaBphDBZ7xKp7omy++waWQCUWeehAO8p7J36RI9kk1hI9DpVQySd
         DgfHwaZoVmh0ZlsxOH1T+/p8Ct/+c8KB0qnvnAMTECYV8QBXZ3TuIRLgMrRb9ND5H4dr
         RY11o2VWI6ydsgwpvBNpAakdDveSSDFHxVc8RNWHgrZ7yJE6oZe83DsH5aIfM2TbZ6m2
         2X4AL45OdpyaGm0tXOWA+r1BRgDgDZdeqxL9qYkvq7usRy/4UBVefQf1TJk2v4diEjdA
         5hwhzhH/uRx3FrxWqdbsnossQM4ORTVI6bzvfgYvBANuEf8xuYdA1WpyMzMdjQ5Xeqz2
         4ORA==
X-Gm-Message-State: AOAM53023V+suqf4zrfSutE2ZKh+8rre6NSo7HDwNxCN2mSBD0RgjmI6
        He7dEY62J4gVE0ExW3XypcOZqQ==
X-Google-Smtp-Source: ABdhPJyyL46ChgPArznD6bCb/vCFF4f87AcabvZFleu+fYVN8dlJ33HXrIxgEFx6MEMvMN0ItHP9Vg==
X-Received: by 2002:a05:622a:6:: with SMTP id x6mr14131824qtw.1.1618876332119;
        Mon, 19 Apr 2021 16:52:12 -0700 (PDT)
Received: from [192.168.1.161] (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id u11sm9934891qta.91.2021.04.19.16.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 16:52:11 -0700 (PDT)
Message-ID: <f2d4ba09466d00c8fe22531307d0057fd7c1860b.camel@kepstin.ca>
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection
 on AMD processors
From:   calvin.walton@kepstin.ca
To:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        yu.c.chen@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de
Cc:     wei.huang2@amd.com
Date:   Mon, 19 Apr 2021 19:52:09 -0400
In-Reply-To: <20210419195812.147710-1-terry.bowman@amd.com>
References: <20210419195812.147710-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-04-19 at 14:58 -0500, Terry Bowman wrote:

@@ -3281,7 +3326,7 @@ static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg
                        continue;
                ret = get_msr(cpu, offset, &msr_cur);
                if (ret) {
-                       fprintf(outf, "Can not update msr(0x%x)\n", offset);
+                       fprintf(outf, "Can not update msr(0x%lx)\n", offset);

This gives a warning when compiled on 32-bit, since turbostat is
compiled with -D_FILE_OFFSET_BITS=64:

turbostat.c: In function 'update_msr_sum':
turbostat.c:3329:42: warning: format '%lx' expects argument of type
'long unsigned int', but argument 3 has type 'off_t' {aka 'long long
int'} [-Wformat=]
 3329 |    fprintf(outf, "Can not update msr(0x%lx)\n", offset);
      |                                        ~~^      ~~~~~~
      |                                          |      |
      |                                          |      off_t {aka long long int}
      |                                          long unsigned int
      |                                        %llx

Easiest fix is probably to cast to (long long int) and use the %llx
format specifier. That should be valid with i686, x32, and amd64
userspace.

Everything else looks fine as far as I can tell, so feel free to add a

Reviewed-by: Calvin Walton <calvin.walton@kepstin.ca>

once you've fixed that warning.


-- 
 <calvin.walton@kepstin.ca>

