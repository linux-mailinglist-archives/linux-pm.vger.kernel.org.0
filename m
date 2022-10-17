Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36C960075D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Oct 2022 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJQHKh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Oct 2022 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJQHKe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2022 03:10:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DC3564C5
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 00:10:19 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 3so10281355pfw.4
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 00:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl1N4Df+WtYT3LT6E7CtK34g4PP7FKB/VpKT3kWBqFQ=;
        b=rPZpbBBUn+i2fp6XsmuR18Mr4fxLhwlqpyfNY9ldnmUlAew7u9Z3BJ84qR/AgWCD78
         D/qPrmlDXy7mICNMFQUBtmcMiMTrEv7TOOEfTtHEY41It/u82Y0rRYnFZXAnZgUvSa2H
         2SxrSAYs1KEaLTN1T6WiKJCalQnfj0woUIDefxLF7OQy5Q+LxThrqjQbELcGqaeMb71J
         1p3uWsINoFXlO444lJnLKI42w/tYgobPs9u0vnwcWYDjnvCn/BA7Vpo6G5BP/Ln4qGLS
         hG0Dbx9s4bzo7fCZThioUSDcxe8Z/1EJyF6n6K2uBr260wjHgHHdo9EWk10emXios4JI
         DLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl1N4Df+WtYT3LT6E7CtK34g4PP7FKB/VpKT3kWBqFQ=;
        b=v0gCr3zrDItK/HrhHlUfIPXT34AvtjVAIZFSBpT5vVAJ4SOlgoCu3owLlNWEAGp9Oa
         bWAbyuWBGqEk8dOnWI40C6cCy3/C2aVVNulpAtdLIUCqbeb4AhOjjRPS/BiZKpRGWeJo
         Rx9sgTLlvawwVbB+C/xboAQ6QYsXMu/JVFkPjRiZiuYy1sReYz3r0nDigZe+6syYpah9
         aPhOJqgSexsBKKQWmM7oF1eUn8sYYyRnX2/Vh31det5h/zqwXkLOqCepVSVONgW3V7Zs
         km+Kd3CZ81eIeSgdk6e76Wx0kI5NZKnYqX7mRZFUPXNB3SmTGIk4HhFjmh8hPZwUNBTT
         GA1A==
X-Gm-Message-State: ACrzQf2wQHvf6fo5eNIIXUQdd5XxkcaBAzwjrDtt4s5r5zwaGGxI/w7n
        Xo0Yr5C9HOXOygjn3JCvCltL0w==
X-Google-Smtp-Source: AMsMyM5Aum8RxrgtIyrKOZQYCfV0Ma0nPLauYgTAB5ZnXGhvDFdHjm5/0XFiX6j14Ro1/gllhnVlrQ==
X-Received: by 2002:a63:8a4b:0:b0:460:7c54:1b2b with SMTP id y72-20020a638a4b000000b004607c541b2bmr9408606pgd.499.1665990618805;
        Mon, 17 Oct 2022 00:10:18 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id i18-20020a63e912000000b0045724d09cb4sm5493551pgh.29.2022.10.17.00.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 00:10:18 -0700 (PDT)
Date:   Mon, 17 Oct 2022 12:40:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] thermal: Add cooling device's statistics in sysfs
Message-ID: <20221017071016.tdbq7xbe32nsyheu@vireshk-i7>
References: <Y0ltRJRjO7AkawvE@kili>
 <20221017055735.is4by26po2woxzet@vireshk-i7>
 <Y0z/knSyW1e6Dg3D@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0z/knSyW1e6Dg3D@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-10-22, 10:09, Dan Carpenter wrote:
> I only looked at the 1 example I posted, but so far as I can see from a
> sample size of 1 they are all buggy.  100% buggy.
> 
> This strategy of relying on the drivers to do it correctly was doomed
> from the get go.

Yeah, I realized that too after sending you the email. I am working on
a patch to fix it.

-- 
viresh
