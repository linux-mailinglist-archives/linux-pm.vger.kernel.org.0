Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB7D213A22
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 14:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgGCMdt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 08:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGCMdt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 08:33:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CC4C08C5C1;
        Fri,  3 Jul 2020 05:33:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so29474174wrw.1;
        Fri, 03 Jul 2020 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YWChRI8U5bql1vd+LjhcuGDJidA2Y+nrVW69k/TqKfM=;
        b=eYoe86Aq3092+g8H38oZiqt99elOVS4MoiOjphvAWqqYBA/PQlpSx1orjs/kxGvdHH
         S6Rfw6c7V1AXmEmDQRSvGRgQk6poNEE4iUDwyHOYJdILTvBwtej70+stDofMtxR1T+NH
         M7IMHFtBRWbzhk7wfGMp/JVtx9jlG91ZptUclVdfND0jcjXPkkaqKJHgTKQuJK4Udgt5
         hE0fDw2vI9yP014m9M4wL3h15ciKQzo12fVdIWj0+IdXoRWhHkXKwjfGdC0LddutzTCF
         /yBvvPFMBhd15wV4caEZllD25LZCgWf4qO3F142/83sK1ODiG9xQuq6FonSNFHEdzZoG
         KNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YWChRI8U5bql1vd+LjhcuGDJidA2Y+nrVW69k/TqKfM=;
        b=ti5Y5wMS4VpQhJuY/Wx2jLg+vXoOz9KfFnG0SGzdv5iNqwc/ho9qYaccyUtQrv0zq0
         rwS/uO9ABQiCtFY9OwW7SgZq1ibaydPACtk5WbPd19zlK82HnzoWSgUz2JIbKe7osTPW
         N68nU58BQSF1m/NxwBKNs00fOobENStgFbmUtpMGgM4juCsdkpcKKL1n51J7B3kx5Prq
         7rx5Bh/7aneaeDC+Oa9RUGQzRFT/fVh11cA/yIVYr0GI/znI0cCWnDb31/PWQn/PBTut
         SxNCpRU9+T8F2YwWWZgIhOBCWkb7SFuNm+bt7d874Pl2/WFZcy4d89aK/9TmaQuIAGLQ
         hEhA==
X-Gm-Message-State: AOAM5316YnteKMj3Eb40iZ+LD5W5gENMVANFNVCeC4eLoriA78HcNzLk
        cNGZ5kLxi/qTt/Xn3ahAjJc=
X-Google-Smtp-Source: ABdhPJwId5pwOgLxvZeA3ibhyN3Y+1w1NlrODeEKmyNzl20XnLaQ2ZKRszG8w9ZVwtoqDjhX2uPt7Q==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr36401397wrw.19.1593779627773;
        Fri, 03 Jul 2020 05:33:47 -0700 (PDT)
Received: from macmini.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id f12sm14292219wrw.53.2020.07.03.05.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 05:33:47 -0700 (PDT)
Date:   Fri, 3 Jul 2020 14:33:46 +0200
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     lukasz.luba@arm.com, k.konieczny@samsung.com, krzk@kernel.org,
        kgene@kernel.org, s.nawrocki@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/2] PM / devfreq: Add delayed timer for polling
Message-ID: <20200703123346.6fy6i33ks6nox46a@macmini.local>
References: <CGME20200703061508epcas1p171aa3c0ab832b77e5837d8bd1e563742@epcas1p1.samsung.com>
 <20200703062622.11773-1-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703062622.11773-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

I think it doesn't help on the benchmark I suggested that is doing only memory
accesses. With both timer, I have the same timing.

To test the benchmark with these new patches about timer:

git clone https://github.com/wwilly/benchmark.git \
  && cd benchmark \
  && source env.sh \
  && ./bench_build.sh \
  && bash source/scripts/test_dvfs_mem_patched.sh

The benchmark is set by default to run for 1s, but you can increase this by
tweaking the script as:

taskset 8 ./bench_install/bin/microbe_cache 33554431 0 9722222 <TIME in sec> ${little_freq}


Also, as I reported the issue, would it be possible to add a
Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com> ?
Many thanks in advance.


Best Regards,
Willy
