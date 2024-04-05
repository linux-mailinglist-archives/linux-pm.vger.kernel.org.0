Return-Path: <linux-pm+bounces-5976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290AB89A202
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 17:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D347F28277C
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFF7171062;
	Fri,  5 Apr 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CdTjE8AR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9316F90A
	for <linux-pm@vger.kernel.org>; Fri,  5 Apr 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332786; cv=none; b=SQbXNux5+vrSpuZ5sv4Tg81phjVfe0UG1uoIsmuXDdWMYztFimWgcJPmhQVaUtoZDRY3dCfrVQ/HDn4ypzCmE9+K39ZW/kxRvUlnjLNe+DzIwI0H3CjcVZF0q/EqUOIxnj5Fikwj01GVw6XlW7bLEwhZHdCwajy+tDHh3PW3P7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332786; c=relaxed/simple;
	bh=6WysufP42FX2Az3Xx8MgB1cNuc1CYX+XUTX4q5FvCN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUQplWplZKIMI6Kxs+PxrCm/jc+5lTJeCcZDkExT9JM+TzykWg1GZD9OOC5Y71tRL7oXEe8S1zPKEbOhyEJ6p8dnXNgpxJJOXrYwNXajnrUhNDCZ6SWlKKtkhwP+hF7w4bIoth/kDe+8xU/utfyjRGcii/LKdsbv/TQJ37w4gdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CdTjE8AR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4163181a7ceso4961485e9.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Apr 2024 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712332783; x=1712937583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/+tn7yaOy1bWCod1Hwz4ffQkyy0MXOXzF4xEGdBkSM=;
        b=CdTjE8ARyIrDoCIL7WSqdKga/mX+JFEK79Pi4jCyaf58yf9SvW7NkQNcfHqbHp4W5r
         QPbw7HCfvDOKgZ5bR1EmCP3Nfn1Tn40R+eOWRXyXyahTFxDWNNlptlLkTJ9rLzKeQCA7
         HnZW0wWacuyTjqy85ar0AkWeZCOIasnLZlW3/AftFoGtEa6MUUPVHpms2GrWdvXOAkx1
         nFLnZ2IonAAOcX4LlKDVyfCWj/tVwHuULEz4NbH3X6bYscW3VUaUzsysVqgcSqUreJGs
         sWXp9dkTrCwWkSLVGBjjLlEbNfT7exPe5e2MDN3Ll4xaFqU4eMITnytPqpuqQRbTpky0
         Qw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332783; x=1712937583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/+tn7yaOy1bWCod1Hwz4ffQkyy0MXOXzF4xEGdBkSM=;
        b=IQPA0l3tN5BIb6aDaeOiRz7kj74nTr3BwxUmRKJSTWTZCCCZQfyvNsI5Fh8n2LbfYH
         UQaAMdOl742N3b625PBb3fLl7tu4CRN9+A5mUHXjGxKIzP7QxpWJWxxAQvlOnBv3fm1x
         VqfuPFz2u/sfN975Ve5XSyLJS3fiH3aODc0gTbb7Lwg+yfA2b5CbV7ODoc/pcsCsFyhf
         MCBM5NvfSpab4j12uO9KSC72P4Icanig3V4o3xZEcj1tsB8X0Da3Xpc2m8yfBOOsmTE7
         wo4WbdmBkjNWZMvjNQSJeY4ZNJwRlfcLmt1KxxhV0/Zw2uqeT69l62iw1B7NzNqhbQnj
         9V3A==
X-Forwarded-Encrypted: i=1; AJvYcCWFFzcWVcaI7pweBVd1o3kcu8T+/leBQrO3Ovk/XXkd2ash/inY7XM1XFCKCl/5ppeLpxEbhI652Fu9Gsien1aWihZFFn3rNqY=
X-Gm-Message-State: AOJu0YzCfhLlpwqzowJsgGw7NbzqPwShPEvKLNLr2lV8m13qglcAZC3R
	t0Ndx/t88VP/6uvgX8Op1Hp7Xm7OG2Gk5ufRm+3130hHHdi4w5MsBBcRY5IBWVg=
X-Google-Smtp-Source: AGHT+IHm5FdCsOG2D2FwTVsRXO+4kOPqszWyczb81zB17ksFNLVDMEKpcib6RWK3ysnM3lM9cg2ZBw==
X-Received: by 2002:a05:600c:3107:b0:414:7909:6680 with SMTP id g7-20020a05600c310700b0041479096680mr1487874wmo.16.1712332783307;
        Fri, 05 Apr 2024 08:59:43 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0041632171f51sm1770044wmq.13.2024.04.05.08.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:59:42 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:59:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Max Hsu <max.hsu@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 02/11] dt-bindings: riscv: Add Sdtrig optional CSRs
 existence on DT
Message-ID: <20240405-ebdb2943657ab08d2d563c03@orel>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
 <20240329-dev-maxh-lin-452-6-9-v1-2-1534f93b94a7@sifive.com>
 <20240329-affidavit-anatomist-1118a12c3e60@wendy>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329-affidavit-anatomist-1118a12c3e60@wendy>

On Fri, Mar 29, 2024 at 10:31:10AM +0000, Conor Dooley wrote:
> On Fri, Mar 29, 2024 at 05:26:18PM +0800, Max Hsu wrote:
> > The mcontext/hcontext/scontext CSRs are optional in the Sdtrig extension,
> > to prevent RW operations to the missing CSRs, which will cause
> > illegal instructions.
> > 
> > As a solution, we have proposed the dt format for these CSRs.
> 
> As I mentioned in your other patch, I amn't sure what the actual value
> is in being told about "sdtrig" itself if so many of the CSRs are
> optional. I think we should define pseudo extensions that represent
> usable subsets that are allowed by riscv,isa-extensions, such as
> those you describe here: sdtrig + mcontext, sdtrig + scontext and
> sdtrig + hcontext. Probably also for strig + mscontext. What
> additional value does having a debug child node give us that makes
> it worth having over something like the above?

Yeah, Sdtrig, which doesn't tell you what you get, isn't nice at all.
I wonder if we can start with requiring Sdtrig to be accompanied by
Ssstrict in order to enable the context CSRs, i.e.

 Sdtrig          - support without optional CSRs
 Sdtrig+Ssstrict - probe for optional CSRs, support what's found

If there are platforms with Sdtrig and optional CSRs, but not Ssstrict,
then maybe the optional CSRs can be detected in some vendor-specific way,
where the decision as to whether or not that vendor-specific way is
acceptable is handled case-by-case.

Thanks,
drew

> 
> Thanks,
> Conor.
> 
> > 
> > Signed-off-by: Max Hsu <max.hsu@sifive.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index d87dd50f1a4b..c713a48c5025 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -137,6 +137,24 @@ properties:
> >        DMIPS/MHz, relative to highest capacity-dmips-mhz
> >        in the system.
> >  
> > +  debug:
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        const: riscv,debug-v1.0.0
> > +      trigger-module:
> > +        type: object
> > +        description: |
> > +          An indication set of optional CSR existence from
> > +          riscv-debug-spec Sdtrig extension
> > +        properties:
> > +          mcontext-present:
> > +            type: boolean
> > +          hcontext-present:
> > +            type: boolean
> > +          scontext-present:
> > +            type: boolean
> > +
> >  anyOf:
> >    - required:
> >        - riscv,isa
> > 
> > -- 
> > 2.43.2
> > 



> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv


